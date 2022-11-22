//
//  FastCampusViewController.swift
//  LearnSwift
//
//  Created by Sungin Hong on 2022/11/19.
//

import UIKit

class FastCampusViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }


    @IBAction func COVID19button(_ sender: Any) {
        GeneralHelper.shared.appDelegate.createCOVID19ViewController()
    }

    @IBAction func SpotifyLogin(_ sender: Any) {
        GeneralHelper.shared.appDelegate.createSpotifyLoginViewController()
    }


    @IBAction func CreditCardList(_ sender: Any) {
        GeneralHelper.shared.appDelegate.createCreditCardListViewController()
    }
}
