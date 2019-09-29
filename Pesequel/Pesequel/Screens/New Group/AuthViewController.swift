//
//  AuthViewController.swift
//  Pesequel
//
//  Created by Ghost on 29.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var button: UIButton!
  
  enum Mode: String {
    case phone = "Авторизуйтесь\nи Готово!"
    case sms = "Проверяем ваш\nтелефон"
  }
  var phone: String?
  var mode: Mode = .phone
  
  override func viewDidLoad() {
    super.viewDidLoad()
    label.text = mode.rawValue
    if mode == .phone {
      textField.placeholder = "+7 XXX XXX XX XX"
      textField.keyboardType = .phonePad
    } else {
      textField.placeholder = "Код из СМС"
      textField.keyboardType = .numberPad
    }
    textField.layer.cornerRadius = 12
    addTargets()
    enableButtonIfNeeded()
    textField.becomeFirstResponder()
  }
  
  private func enableButtonIfNeeded() {
    let condition: Bool = {
      let count = (textField.text ?? "").count
      if mode == .phone {
        return count == "+7XXXXXXXXXX".count
      } else {
        return count == 6
      }
    }()
    button.isEnabled = condition
    let image = condition ? UIImage(named: "next-active") : UIImage(named: "next-inactive")
    button.setBackgroundImage(image, for: .normal)
  }
  
  @IBAction func buttonClicked() {
    if mode == .phone {
      let phone = textField.text ?? ""
      AuthManager.shared.send(codeTo: phone) {
        let vc = AuthViewController()
        vc.mode = .sms
        vc.phone = phone
        self.presentAsStork(vc)
      }
    } else {
      let phone = self.phone ?? ""
      let code = self.textField.text ?? ""
      AuthManager.shared.confirmCode(with: phone, code: code) { (isSucceeded) in
        if isSucceeded {
          let mapVC = UINavigationController(rootViewController: MapViewController())
          self.present(mapVC, animated: true, completion: nil)
        } else {
          let alertController = UIAlertController(title: "Ошибка", message: "Код неверный", preferredStyle: .alert)
          alertController.addAction(.init(title: "Ок", style: .default, handler: nil))
          self.present(alertController, animated: true, completion: nil)
        }
      }
    }
  }
  
  private func addTargets() {
    textField.addTarget(self, action: #selector(textFieldChanged(sender:)), for: .editingChanged)
  }
  
  @objc private func textFieldChanged(sender: UITextField) {
//    sender.text = formattedNumber(number: sender.text ?? "")
    enableButtonIfNeeded()
  }
  
  private func formattedNumber(number: String) -> String {
    let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    
    var result = ""
    var index = cleanPhoneNumber.startIndex
    let mask = mode == .phone ? "+7 XXX XXX XX XX" : "XXXX"
    for ch in mask where index < cleanPhoneNumber.endIndex {
      if ch == "X" {
        result.append(cleanPhoneNumber[index])
        index = cleanPhoneNumber.index(after: index)
      } else {
        result.append(ch)
      }
    }
    return result
  }

}
