//
//  ProfileViewController.swift
//  PetFinder
//
//  Created by Va Leroni on 01.03.2022.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
  @IBAction func logoutTapped() {
    do {
      try Auth.auth().signOut()
      transitionToWelcome()
    } catch {
      fatalError("Logout")
    }
  }
  func transitionToWelcome() {
    let mainVC = storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as! UINavigationController
    view.window?.rootViewController = mainVC
    view.window?.makeKeyAndVisible()
  }
}
