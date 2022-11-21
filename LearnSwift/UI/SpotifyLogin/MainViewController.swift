//
//  MainViewController.swift
//  LearnSwift
//
//  Created by Sungin Hong on 2022/11/20.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var resetPasswordButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false //모든 pop제스쳐를 막는다.


        let email = Auth.auth().currentUser?.email ?? "고객"

        welcomeLabel.text = """
        환영합니다.
        \(email)님
        """

        let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
        resetPasswordButton.isHidden = !isEmailSignIn
    }

    @IBAction func resetPasswordButton(_ sender: Any) {
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func resetPasswordButtonTapped(_ sender: Any) {

        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email) //reset 메일전송
    }

    @IBAction func logoutButtonTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()

        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)

        } catch let signOutError as NSError {
            print("Error: \(signOutError.localizedDescription)")
        }

    }

    @IBAction func profileUpdateButtonTapped(_ sender: Any) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = "토끼"

        changeRequest?.commitChanges { [weak self] _ in
            let displayName = Auth.auth().currentUser?.displayName ?? Auth.auth().currentUser?.email ?? "고객"
            self?.welcomeLabel.text = """
            환영합니다.
            \(displayName)
            """
        }
    }
}
