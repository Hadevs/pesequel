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
  @IBOutlet weak var tableView: UITableView!
  var willDismiss: VoidClosure?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorColor = .clear
    tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    tableView.register(CartTableViewCell.self)
    addHeaderView()
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    SPStorkController.scrollViewDidScroll(scrollView)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    willDismiss?()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.updateHeaderViewHeight()
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
        self.dismissIfNeeded()
      }
    })]
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cartProduct = products[indexPath.row]
    let cell: CartTableViewCell = tableView.getCell(for: indexPath)
    cell.minusClicked = {
      if let product = cartProduct.product {
        let isRemoved = Cart.shared.remove(product: product)
        if isRemoved {
          self.safeDelete(at: indexPath)
        } else {
          tableView.reloadData()
        }
      }
      self.dismissIfNeeded()
    }
    
    cell.plusClicked = {
      if let product = cartProduct.product {
        Cart.shared.add(product: product)
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
    return 79
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return products.count
  }
}
