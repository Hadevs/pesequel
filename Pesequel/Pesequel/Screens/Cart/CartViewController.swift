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
    tableView.tableHeaderView = headerView
  }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cartProduct = products[indexPath.row]
    let cell: CartTableViewCell = tableView.getCell(for: indexPath)
    cell.minusClicked = {
      if let product = cartProduct.product {
        let isRemoved = Cart.shared.remove(product: product)
        if isRemoved {
          CATransaction.begin()
          tableView.beginUpdates()
          tableView.isUserInteractionEnabled = false
          CATransaction.setCompletionBlock {
            tableView.isUserInteractionEnabled = true
            tableView.reloadData()

          }
          tableView.deleteRows(at: [indexPath], with: .left)
          tableView.endUpdates()
          CATransaction.commit()
        } else {
          tableView.reloadData()
        }
      }
      if Cart.shared.totalAmount == 0 {
        self.dismiss(animated: true, completion: nil)
      }
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
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 79
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return products.count
  }
}
