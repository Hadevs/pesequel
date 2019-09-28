//
//  ProductCollectionViewCell.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell, NibLoadable {
  @IBOutlet weak var photoView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var massLabel: UILabel!
  @IBOutlet weak var priceButton: UIButton!
  @IBOutlet weak var amountLabel: UILabel!
  @IBOutlet weak var amountBackView: UIView!
  
  var clicked: VoidClosure?
  override func awakeFromNib() {
    super.awakeFromNib()
    priceButton.addTarget(self, action: #selector(buyButtonAction), for: .touchUpInside)
  }
  
  @objc private func buyButtonAction() {
    clicked?()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.borderColor = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1).cgColor
    layer.borderWidth = 1
    layer.cornerRadius = 10
    amountBackView.round()
  }
  
  func configure(by product: Product) {
    ImageLoader(photoView).load(product)
    nameLabel.text = product.name
    massLabel.text = ("\(product.mass ?? "???") г")
    UIView.performWithoutAnimation {
      priceButton.setTitle("\(product.price ?? "???") ₽", for: .normal)
      priceButton.layoutIfNeeded()
    }
    let amount = Cart.shared.amount(of: product)
    if amount > 0 {
      amountBackView.isHidden = false
      amountLabel.text = "\(amount)"
    } else {
      amountBackView.isHidden = true
      amountLabel.text = nil
    }
  }
}
