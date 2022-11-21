//
//  SplashViewController.swift
//  LearnSwift
//
//  Created by Sungin Hong on 2022/11/18.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        GeneralHelper.shared.appDelegate.createHomeViewController()
    }
    



}
