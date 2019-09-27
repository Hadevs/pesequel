//
//  NavigationBarDecorator.swift
//  Pesequel
//
//  Created by Ghost on 27.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class NavigationBarDecorator {
  private let viewController: UIViewController
  init(_ vc: UIViewController) {
    self.viewController = vc
  }
  
  func decorate() {
    viewController.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)]
    viewController.navigationController?.navigationBar.barTintColor = .white
    viewController.navigationController?.navigationBar.isTranslucent = false
    viewController.navigationController?.navigationBar.shadowImage = UIImage()
  }
}
