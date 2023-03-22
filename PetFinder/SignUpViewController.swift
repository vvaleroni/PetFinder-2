//
//  SignUpViewController.swift
//  Petfinder
//
//  Created by Va Leroni on 21.02.22.
//


import UIKit
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var firstnameTextField: UITextField!
  @IBOutlet weak var lastnameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextFiled: UITextField!
  
  @IBOutlet weak var signupButton: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  @IBAction func signupTapped(_ sender: UIButton) {
    guard let email = emailTextField.text, !email.isEmpty else {return }
    guard let password = passwordTextFiled.text else {return }
    guard let firstname = firstnameTextField.text else {return }
    guard let lastname = lastnameTextField.text else {return }
    
    Auth.auth().createUser(withEmail: email, password: password) { result, error in
      if let error = error {
        self.showError(error.localizedDescription)
      } else {
        self.signupButton.isEnabled = false
        self.showError("Пожалуйста подождите")
        let db = Firestore.firestore()
        guard let uid = result?.user.uid else { return }
        db.collection("users")
          .document(uid)
          .setData([
            "firstname": firstname,
            "lastname": lastname,
            "email": email
          ]) { error in
            if let error = error {
              self.showError(error.localizedDescription)
            } else {
              self.transitionToMain()
            }
          }
      }
    }
  }
  func showError(_ message: String) {
    errorLabel.text = message
    errorLabel.alpha = 1
  }
  func setupUI() {
    errorLabel.alpha = 0
    Utilities.styleFilledButton(signupButton)
  }
  
  func transitionToMain() {
    let mainVC = storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
    view.window?.rootViewController = mainVC
    view.window?.makeKeyAndVisible()
  }
}
