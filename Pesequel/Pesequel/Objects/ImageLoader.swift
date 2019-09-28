//
//  ImageLoader.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class ImageLoader {
  private let imageView: UIImageView
  init(_ imageView: UIImageView) {
    self.imageView = imageView
  }
  
  func load(_ cafe: Cafe) {
    imageView.kf.setImage(with: URL(string: cafe.image ?? ""))
  }
  
  func load(_ product: Product) {
    imageView.kf.setImage(with: URL(string: product.image ?? ""))
  }
}
