//
//  Utilities.swift
//  PetFinder
//
//  Created by Va Leroni on 01.03.2022.
//



import Foundation
import UIKit

class Utilities {
  
//  static func styleTextField(_ textfield:UITextField) {
//
//    // Create the bottom line
//    let bottomLine = CALayer()
//
//    bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
//
//    bottomLine.backgroundColor = UIColor.brandPet.cgColor
//
//    // Remove border on text field
//    textfield.borderStyle = .none
//
//    // Add the line to the text field
//    textfield.layer.addSublayer(bottomLine)
//
//  }
  
  static func styleFilledButton(_ button:UIButton) {
    
    // Filled rounded corner style
    button.backgroundColor = .brandPet
    button.layer.cornerRadius = 20.0
    button.tintColor = UIColor.white
  }
  
  static func styleHollowButton(_ button:UIButton) {
    
    // Hollow rounded corner style
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.brandPet.cgColor
    button.layer.cornerRadius = 20.0
    button.tintColor = UIColor.brandPet
  }
  
//  static func isPasswordValid(_ password : String) -> Bool {
//
//    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
//    return passwordTest.evaluate(with: password)
//  }
  
}

extension UIColor {
  static let brandLightGreen = #colorLiteral(red: 0.6114080548, green: 0.9031038284, blue: 0.7109999061, alpha: 1)
  static let brandPet = #colorLiteral(red: 0.3690882325, green: 0.9068933725, blue: 0.7585387826, alpha: 1)
}
