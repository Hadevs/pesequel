//
//  ProductsTableViewCell.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class ProductsTableViewCell: BasicTableViewCell, NibLoadable {
  
  var products: [Product] = [] {
    didSet {
      reloadData()
    }
  }
  private let numberOfColumns: CGFloat = 2
  private let spacing: CGFloat = 23
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
  var productSelected: ItemClosure<Product>?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.delegate = self
    collectionView.dataSource = self

    collectionView.showsHorizontalScrollIndicator = false
    collectionView.register(ProductCollectionViewCell.nib, forCellWithReuseIdentifier: ProductCollectionViewCell.name)
    collectionView.isScrollEnabled = false
  }
  
  func configure() {

  }

  private func reloadData() {
    collectionView?.reloadData()
    collectionViewHeightConstraint?.constant = collectionView?.collectionViewLayout.collectionViewContentSize.height ?? 0
  }
}

extension ProductsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0,
                        left: spacing,
                        bottom: 0,
                        right: spacing)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.name, for: indexPath) as! ProductCollectionViewCell
    let product = products[indexPath.row]
    cell.clicked = {
      self.productSelected?(product)
    }
    cell.configure(by: product)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return spacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return spacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let numberOfItemsPerRow: CGFloat = numberOfColumns
    let marginLeft = spacing
    let marginRight = spacing
    let colomnSpacing = spacing
    let totalSpace = marginLeft + marginRight + (colomnSpacing * CGFloat(numberOfItemsPerRow - 1))
    let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
    
    // 20 is for label height.
    return CGSize(width: size, height: size * 260/154)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return products.count
  }
}
