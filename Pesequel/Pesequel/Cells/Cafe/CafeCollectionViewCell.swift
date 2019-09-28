//
//  CafeCollectionViewCell.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit
import Kingfisher

class CafeCollectionViewCell: UICollectionViewCell, NibLoadable {
  @IBOutlet weak var imageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    imageView.layer.borderColor = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1).cgColor
    imageView.layer.borderWidth = 1
    imageView.layer.cornerRadius = 6
    // Initialization code
  }
  
  func configure(by cafe: Cafe) {
    ImageLoader(imageView).load(cafe)
  }
}
