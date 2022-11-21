//
//  EnterEmailViewController.swift
//  LearnSwift
//
//  Created by Sungin Hong on 2022/11/20.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!

    @IBOutlet weak var nextButton: UIButton!



    override func viewDidLoad() {
        super.viewDidLoad()

        nextButton.layer.cornerRadius = 30
        nextButton.isEnabled = false


        emailTextField.delegate = self
        passwordTextField.delegate = self

        emailTextField.becomeFirstResponder()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

    }


    @IBAction func nextButtonTapped(_ sender: Any) {
        //Firebase 이메일/비밀번호 인증
        let email = emailTextField.text ?? ""

        let password = passwordTextField.text ?? ""

        //신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }

            if let error = error as? NSError {
                let code = error.code
                switch code {
                case 17007: //이미 가입한 계정일때.
                    self.loginUser(withEamil: email, password: password)
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            } else {
                self.showMainViewController()
            }

        }
    }

    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "SpotifyLogin", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen

        self.navigationController?.show(mainViewController, sender: nil)

    }

    private func loginUser(withEamil email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }

            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()

            }
        }
    }
}

extension EnterEmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing()

        self.view.endEditing(true)
        return false

    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""


        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }

}
