//
//  CafesTableViewCell.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class CafesTableViewCell: BasicTableViewCell, NibLoadable {
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
  private let numberOfColumns: CGFloat = 3
  private let spacing: CGFloat = 21
  var cafes: [Cafe] = [] {
    didSet {
      reloadData()
    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    configureCollectionView()
    collectionView.register(CafeCollectionViewCell.nib, forCellWithReuseIdentifier: CafeCollectionViewCell.name)
    
  }
  
  private func reloadData() {
    collectionView?.reloadData()
    collectionViewHeightConstraint?.constant = collectionView?.collectionViewLayout.collectionViewContentSize.height ?? 0
  }
  
  private func configureCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.contentInset = UIEdgeInsets(top: 0,
                                               left: spacing,
                                               bottom: 0,
                                               right: spacing)
  }
}

extension CafesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CafeCollectionViewCell.name, for: indexPath) as! CafeCollectionViewCell
    let cafe = cafes[indexPath.row]
    cell.configure(by: cafe)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return spacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return spacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let sideValue = (UIScreen.main.bounds.width - (spacing * (numberOfColumns - 1)) - spacing * 2) / numberOfColumns
    return CGSize(width: sideValue, height: sideValue)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cafes.count
  }
}
