//
//  SpotifyLoginViewController.swift
//  LearnSwift
//
//  Created by Sungin Hong on 2022/11/20.
//

import UIKit
import GoogleSignIn

class SpotifyLoginViewController: UIViewController {

    @IBOutlet weak var appleLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var emailLoginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        [appleLoginButton, googleLoginButton, emailLoginButton].forEach { button in
            button?.layer.borderWidth = 1
            button?.layer.borderColor = UIColor.white.cgColor
            button?.layer.cornerRadius = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        
        //Google SIgn In
        GIDSignIn.sharedInstance().presentingViewController = self
    }


    @IBAction func googleLoginButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }

    @IBAction func appleLoginButtonTapped(_ sender: Any) {
    }


    @IBAction func homeButtonTapped(_ sender: Any) {
        GeneralHelper.shared.appDelegate.createHomeViewController()
    }
}
