//
//  LoginViewController.swift
//  Petfinder
//
//  Created by Va Leroni on 20.02.22.
//


import UIKit
import Firebase
class LoginViewController: UIViewController {
  
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  @IBAction func loginTapped(_ sender: UIButton) {
    guard let email = emailTextField.text else {return }
    guard let password = passwordTextField.text else {return }
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
      if let error = error {
        self.showError(error.localizedDescription)
      } else {
        self.showError("Пожалуйста подождите")
        self.transitionToMain()
      }
    }
  }
  func setupUI() {
    errorLabel.alpha = 0
    Utilities.styleFilledButton(loginButton)
  }
  func showError(_ message: String) {
    errorLabel.text = message
    errorLabel.alpha = 1
  }
  func transitionToMain() {
    let mainVC = storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
    view.window?.rootViewController = mainVC
    view.window?.makeKeyAndVisible()
  }
}
