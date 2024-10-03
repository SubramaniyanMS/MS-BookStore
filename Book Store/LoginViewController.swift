//
//  LoginViewController.swift
//  Book Store
//
//  Created by Apple on 20/09/24.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoginViewController loaded")
    }

    @IBAction func SignInBtn(_ sender: Any) {
        print("SignInBtn clicked")
        if let navController = navigationController {
            print("NavigationController exists")
        } else {
            print("NavigationController is NIL!")
        }

        if let bookStoreVC = storyboard?.instantiateViewController(withIdentifier: "BookStoreViewController") as? BookStoreViewController {
            print("Navigating to BookStoreViewController")
            navigationController?.pushViewController(bookStoreVC, animated: true)
        } else {
            print("BookStoreViewController not found!")
        }
    }

}

