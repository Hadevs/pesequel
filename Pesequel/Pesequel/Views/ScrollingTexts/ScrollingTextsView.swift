//
//  ScrollingTextsTableViewCell.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class ScrollingTextsView: UIView, NibLoadable {
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var scrollContentView: UIView!
  private var labels: [UILabel] = []
  var titles: [String] = [] {
    didSet {
      reloadRows()
    }
  }
  
  var titleSelected: ItemClosure<String>?
  override func awakeFromNib() {
    super.awakeFromNib()
    scrollView.contentInset = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 0)
    scrollView.showsHorizontalScrollIndicator = false
  }
  
  func select(index: Int) {
    guard labels.indices.contains(index) else {
      return
    }
    for label in labels {
      Animation.medium {
        label.textColor = UIColor.black.withAlphaComponent(0.18)
      }
    }
    
    let label = labels[index]
    Animation.medium {
      label.transform = CGAffineTransform(scaleX: 1.08, y: 1.08)
      Animation.fast {
        label.transform = .identity
      }
    }
    Animation.medium {
      label.textColor = .black
    }
  }
  
  private func reloadRows() {
    scrollContentView?.subviews.forEach { $0.removeFromSuperview() }
    for (index, title) in titles.enumerated() {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      scrollContentView?.addSubview(label)
      label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
      label.text = title
      label.textColor = UIColor.black.withAlphaComponent(0.18)
      if index == 0 {
        label.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
      } else {
        let prevLabel = labels[index - 1]
        label.leadingAnchor.constraint(equalTo: prevLabel.trailingAnchor, constant: 12).isActive = true
      }
      if index == titles.count - 1 {
//        label.trailingAnchor.constraint(greaterThanOrEqualTo: scrollContentView.trailingAnchor).isActive = true
      }
      label.topAnchor.constraint(equalTo: scrollContentView.topAnchor).isActive = true
      label.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor).isActive = true
      label.isUserInteractionEnabled = true
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(sender:)))
      label.addGestureRecognizer(tapGesture)
      labels.append(label)
    }
  }
  
  @objc private func labelTapped(sender: UITapGestureRecognizer) {
    guard let label = sender.view as? UILabel else {
      return
    }
    
    guard let index = labels.firstIndex(of: label) else {
      return
    }
    
    select(index: index)
    titleSelected?(titles[index])
  }
}
