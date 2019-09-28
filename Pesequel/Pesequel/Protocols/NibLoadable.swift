//
//  NibLoadable.swift
//  cphr-ios
//
//  Created by Ghost on 23/10/2018.
//  Copyright © 2018 Ghost. All rights reserved.
//

import UIKit

public extension NibLoadable {
  static var name: String {
    return String(describing: self)
  }
}
public protocol NibLoadable: class {
  static var nib: UINib { get }
}

public extension NibLoadable {
  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: Bundle.init(for: Self.self))
  }
}

public extension NibLoadable where Self: UIView {
  static func loadFromNib() -> Self {
    guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
      fatalError("The nib \(nib) expected its root view to be of type \(self)")
    }
    return view
  }
}
