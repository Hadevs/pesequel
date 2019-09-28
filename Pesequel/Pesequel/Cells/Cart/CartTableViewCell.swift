//
//  CartTableViewCell.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class CartTableViewCell: BasicTableViewCell, NibLoadable {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var massLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  @IBOutlet weak var minusButton: UIButton!
  @IBOutlet weak var plusButton: UIButton!
  @IBOutlet weak var photoView: UIImageView!
  
  var minusClicked: VoidClosure?
  var plusClicked: VoidClosure?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  @IBAction func plusButtonAction() {
    plusClicked?()
  }
  
  @IBAction func minusButtonAction() {
    minusClicked?()
  }
  
  func configure(by product: CartProduct) {
    nameLabel.text = product.product?.name
    priceLabel.text = "\(product.product?.price ?? "???") ₽"
    massLabel.text = "\(product.product?.mass ?? "???") г"
    amountLabel.text = "\(product.amount)"
    ImageLoader(photoView).load(product)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
