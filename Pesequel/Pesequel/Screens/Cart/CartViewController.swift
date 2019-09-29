//
//  CartViewController.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import SPStorkController

class CartViewController: UIViewController {
  var products: List<CartProduct> {
    return Cart.shared.products
  }
  
  private var newOrderRequest = NewOrderRequest() {
    didSet {
      tableView.reloadData()
    }
  }
  
  enum SectionModel: CaseIterable {
    case segment
    case products
    case description
    case paymentAndTime
    case button
  }
  
  private let sectionModels = SectionModel.allCases
  private let datePicker = UIDatePicker()
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var cafeLabel: UILabel!
  var willDismiss: VoidClosure?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTableView()
    addDatePickerView()
    addTableViewGesture()
    cafeLabel.text = Cart.shared.currentCafe?.name ?? "???"
    newOrderRequest.refplace = Cart.shared.currentCafe?.uid
    newOrderRequest.ordered = Array(Cart.shared.products)
    newOrderRequest.pick_up_type = SegmentTableViewCell.PickupType.inPlace.rawValue
    newOrderRequest.to_be_ready_at = "\(Date().timeIntervalSince1970)"
  }
  
  private func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorColor = .clear
    tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    tableView.register(CartTableViewCell.self)
    tableView.register(SegmentTableViewCell.self)
    tableView.register(PaymentAndTimeTableViewCell.self)
    tableView.register(LabelTableViewCell.self)
    tableView.register(ButtonTableViewCell.self)
  }
  
  @objc private func datePickerChanged(sender: UIDatePicker) {
    newOrderRequest.to_be_ready_at = "\(sender.date.timeIntervalSince1970)"
  }
  
  private func addTableViewGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
    tableView.addGestureRecognizer(tapGesture)
  }
  
  @objc private func tableViewTapped() {
    hidePickerView(animated: true)
  }
  
  private func addDatePickerView() {
    let height: CGFloat = view.frame.width * 0.8
    view.addSubview(datePicker)
    datePicker.minimumDate = Date()
    datePicker.backgroundColor = .white
    datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
    datePicker.maximumDate = Date().addingTimeInterval(60 * 60 * 24 * 3)
    datePicker.datePickerMode = .dateAndTime
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    datePicker.heightAnchor.constraint(equalToConstant: height).isActive = true
    datePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    hidePickerView(animated: false)
  }
  
  private func showPickerView(animated: Bool) {
    Animation.fast {
      self.datePicker.transform = .identity
    }
  }
  
  private func hidePickerView(animated: Bool) {
    let duration = animated ? 0.35 : 0
    let height: CGFloat = view.frame.width * 0.8
    UIView.animate(withDuration: duration) {
      self.datePicker.transform = CGAffineTransform(translationX: 0, y: height)
    }
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    SPStorkController.scrollViewDidScroll(scrollView)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    willDismiss?()
  }
  
  
  private func addHeaderView() {
    let headerView = SubtitleLabelView.loadFromNib()
    headerView.subtitleLabel.text = Cart.shared.currentCafe?.name
    tableView.tableHeaderView = headerView
  }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    return [.init(style: .destructive, title: "Удалить", handler: { (_, indexPath) in
      let cartProduct = self.products[indexPath.row]
      if let product = cartProduct.product {
        Cart.shared.fullyDelete(product: product)
        self.safeDelete(at: indexPath)
        self.newOrderRequest.ordered = Array(Cart.shared.products)
        self.dismissIfNeeded()
      }
    })]
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = sectionModels[indexPath.section]
    switch model {
    case .segment:
      return getSegmentCell(of: tableView, for: indexPath)
    case .products:
      return getProductCell(of: tableView, for: indexPath)
    case .description:
      return getDescriptionCell(of: tableView, for: indexPath)
    case .paymentAndTime:
      return getPaymentAndTimeCell(of: tableView, for: indexPath)
    case .button:
      return getButtonTableViewCell(of: tableView, for: indexPath)
    }
  }
  
  private func getButtonTableViewCell(of tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
    let cell: ButtonTableViewCell = tableView.getCell(for: indexPath)
    cell.setActivated(newOrderRequest.isFilled)
    cell.buttonClicked = orderButtonClicked
    return cell
  }
  
  private func orderButtonClicked() {
    PlaceManager.shared.postOrder(orderRequest: newOrderRequest) { (error) in
      Cart.shared.products = List()
      let alertController = UIAlertController(title: "Заказ", message: error ?? "Заказ успешно оформлен.", preferredStyle: .alert)
      alertController.addAction(.init(title: "Продолжить", style: .default, handler: { (_) in
        self.dismiss(animated: true) {
          self.parent?.navigationController?.popToRootViewController(animated: true)
        }
      }))
      self.present(alertController, animated: true, completion: nil)
      
    }
  }
  
  private func getPaymentAndTimeCell(of tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
    let cell: PaymentAndTimeTableViewCell = tableView.getCell(for: indexPath)
    cell.timeClicked = {
      self.showPickerView(animated: true)
    }
    return cell
  }
  
  private func getDescriptionCell(of tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
    let cell: LabelTableViewCell = tableView.getCell(for: indexPath)
    return cell
  }
  
  private func getSegmentCell(of tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
    let cell: SegmentTableViewCell = tableView.getCell(for: indexPath)
    cell.pickupSelected = {
      type in
      self.newOrderRequest.pick_up_type = type.rawValue
    }
    return cell
  }
  
  private func getProductCell(of tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
    let cartProduct = products[indexPath.row]
    let cell: CartTableViewCell = tableView.getCell(for: indexPath)
    cell.minusClicked = {
      if let product = cartProduct.product {
        let isRemoved = Cart.shared.remove(product: product)
        if isRemoved {
          self.safeDelete(at: indexPath)
          self.newOrderRequest.ordered = Array(Cart.shared.products)
        } else {
          tableView.reloadData()
        }
      }
      self.dismissIfNeeded()
    }
    
    cell.plusClicked = {
      if let product = cartProduct.product {
        Cart.shared.add(product: product)
        self.newOrderRequest.ordered = Array(Cart.shared.products)
      }
      tableView.reloadData()
    }
    
    cell.configure(by: cartProduct)
    return cell
  }
  
  private func safeDelete(at indexPath: IndexPath) {
    CATransaction.begin()
    tableView.beginUpdates()
    tableView.isUserInteractionEnabled = false
    CATransaction.setCompletionBlock {
      self.tableView.isUserInteractionEnabled = true
      self.tableView.reloadData()
    }
    tableView.deleteRows(at: [indexPath], with: .left)
    tableView.endUpdates()
    CATransaction.commit()
  }
  
  private func dismissIfNeeded() {
    if Cart.shared.totalAmount == 0 {
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let sectionModel = sectionModels[indexPath.section]
    switch sectionModel {
    case .products: return 79
    case .description: return UITableView.automaticDimension
    case .paymentAndTime: return 85
    case .segment: return 50
    case .button: return 50
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch sectionModels[section] {
    case .products: return products.count
    default: return 1
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sectionModels.count
  }
}
