//
//  CafeViewController.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
import SPStorkController

class CafeViewController: UIViewController {
  enum SectionModel: CaseIterable {
    case info
    case products
    
    var rows: [CellModel] {
      switch self {
      case .info: return [.info, .orderTaxi]
      case .products: return [.products]
      }
    }
  }
  enum CellModel {
    case info
    case orderTaxi
    case products
  }
  private var cafe: Cafe?
  private var categories: [String: [Product]] = [:] {
    didSet {
      tableView.reloadData()
    }
  }
  
  convenience init(cafe: Cafe) {
    self.init()
    self.cafe = cafe
  }
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var foodButton: UIButton!
  @IBOutlet weak var priceButton: UIButton!
  @IBOutlet weak var cartBackView: UIView!
  private let sectionModels = SectionModel.allCases
  private var selectedCategory = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Заведение"
    separateCategories()
    tableView.delegate = self
    tableView.dataSource = self
    selectedCategory = categories.first?.key ?? ""
    tableView.register(CafeInfoTableViewCell.self)
    tableView.register(DetailButtonTableViewCell.self)
    tableView.register(ProductsTableViewCell.self)
    tableView.alpha = 0
    tableView.separatorColor = .clear
    cartBackView.transform = CGAffineTransform(translationX: 0, y: 78)
    if Cart.shared.totalAmount > 0 {
      self.showCartView()
    }
    updateCartInfo()
    addGestureOnCartView()
  }
  
  private func addGestureOnCartView() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cartViewClicked))
    priceButton.isUserInteractionEnabled = false
    foodButton.isUserInteractionEnabled = false
    cartBackView.isUserInteractionEnabled = true
    cartBackView.addGestureRecognizer(tapGesture)
  }
  
  @objc private func cartViewClicked() {
    let vc = CartViewController()
    let transitioningDelegate = SPStorkTransitioningDelegate()
    transitioningDelegate.swipeToDismissEnabled = true
    transitioningDelegate.translateForDismiss = 100
    vc.transitioningDelegate = transitioningDelegate
    vc.willDismiss = {
      self.tableView.reloadData()
      self.updateCartInfo()
    }
    presentAsStork(vc)
  }
  
  private func updateCartInfo() {
    let priceString = "\(Cart.shared.totalPrice) ₽"
    let amount = "\(Cart.shared.totalAmount) блюд"
    if Cart.shared.totalAmount <= 0 {
      Animation.medium {
        self.cartBackView.transform = CGAffineTransform(translationX: 0, y: 78)
      }
    }
    UIView.performWithoutAnimation {
      foodButton.setTitle(amount, for: .normal)
      foodButton.layoutIfNeeded()
      
      priceButton.setTitle(priceString, for: .normal)
      priceButton.layoutIfNeeded()
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    foodButton.round()
    priceButton.round()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    Animation.medium {
      self.tableView.alpha = 1
    }
    self.tableView.reloadData()
  }
  
  private func separateCategories() {
    let products = cafe?.food ?? List()
    var subDictionary: [String: [Product]] = [:]
    for product in products {
      let category = product.category ?? ""
      if let productsInDictionary = subDictionary[category] {
        var newArray = productsInDictionary
        newArray.append(product)
        subDictionary[category] = newArray
      } else {
        subDictionary[category] = [product]
      }
    }
    self.categories = subDictionary
  }
  
}

extension CafeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    switch sectionModels[section] {
    case .products:
      let headerView = ScrollingTextsView.loadFromNib()
      let strings = categories.map { $0.key }
      
      headerView.titles = strings
      headerView.titleSelected = {
        title in
        self.selectedCategory = title
        tableView.reloadData()
      }
      if let index = strings.firstIndex(of: selectedCategory) {
        headerView.select(index: index)
      }
      return headerView
    case .info: return nil
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    switch sectionModels[section] {
    case .products:
      return 60
    case .info:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = sectionModels[indexPath.section].rows[indexPath.row]
    switch model {
    case .orderTaxi:
      let cell: DetailButtonTableViewCell = tableView.getCell(for: indexPath)
      return cell
    case .info:
      let cell: CafeInfoTableViewCell = tableView.getCell(for: indexPath)
      if let cafe = self.cafe {
        cell.configure(by: cafe)
      }
      return cell
    case .products:
      let cell: ProductsTableViewCell = tableView.getCell(for: indexPath)
      cell.products = categories[selectedCategory] ?? []
      cell.configure()
      cell.productSelected = { product in
        // should be added in cart
        func add() {
          Cart.shared.add(product: product)
          tableView.reloadData()
          self.showCartView()
          self.updateCartInfo()
          
          let realm = try! Realm()
          try? realm.write {
            Cart.shared.currentCafe = self.cafe
          }
        }
        if Cart.shared.currentCafe == nil || Cart.shared.currentCafe?.uid == self.cafe?.uid {
          add()
        } else {
          let alertController = UIAlertController(title: "Новый ресторан", message: "Вы пытаетесь добавить в корзину блюда, но не завершили заказ из прошло ресторана.", preferredStyle: .alert)
          alertController.addAction(UIAlertAction.init(title: "Очистить старый заказ", style: .destructive, handler: { (_) in
            Cart.shared.products = List()
            add()
          }))
          
          alertController.addAction(UIAlertAction.init(title: "Отмена", style: .cancel, handler: nil))
          self.present(alertController, animated: true, completion: nil)
        }
        
      }
      return cell
    }
  }
  
  private func showCartView() {
    Animation.medium {
      self.cartBackView.transform = .identity
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let model = sectionModels[indexPath.section].rows[indexPath.row]
    switch model {
    case .orderTaxi: return 95
    case .info: return 75
    case .products: return UITableView.automaticDimension
    }
  }
  
//  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//    let model = sectionModels[indexPath.section].rows[indexPath.row]
//    switch model {
//    case .orderTaxi: return 95
//    case .info: return 75
//    case .products: return UITableView.automaticDimension
//    }
//  }
//
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let sectionModel = sectionModels[section]
    return sectionModel.rows.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sectionModels.count
  }
}
