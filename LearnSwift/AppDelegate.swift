//
//  AppDelegate.swift
//  LearnSwift
//
//  Created by Sungin Hong on 2022/11/18.
//

import UIKit
import FirebaseCore
import GoogleSignIn
import FirebaseAuth


@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //Firebase 초기화
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self

        return true
    }



    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        print("sungin Check !")
        print(url)
        return GIDSignIn.sharedInstance().handle(url)

    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Error Google Sign in \(error.localizedDescription)")
            return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { [weak self]_, _ in
            guard let self = self else { return }
            self.showSpotifyLoginMainViewController()
        }
    }

    private func showSpotifyLoginMainViewController() {
        let storyboard = UIStoryboard(name: "SpotifyLogin", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen


        window?.rootViewController?.show(mainViewController, sender: nil)
      

    }




    func dismissPresentViewController() {
        if(window?.rootViewController?.presentedViewController != nil) {
            window?.rootViewController?.dismiss(animated: false)
        }
    }


    func createHomeViewController() {
        self.dismissPresentViewController()
        let targetSB: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let targetVC: TabBarViewController = targetSB.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController

        targetVC.modalPresentationStyle = .fullScreen

        let nav = UINavigationController(rootViewController: targetVC)
        self.window?.rootViewController = nav
        nav.isNavigationBarHidden = true

        self.window?.makeKeyAndVisible()



    }

    func createCOVID19ViewController() {
        self.dismissPresentViewController()
        let targetSB = UIStoryboard(name: "COVID19", bundle: nil)
        let targetVC = targetSB.instantiateViewController(withIdentifier: "COVID19ViewController")

        targetVC.modalPresentationStyle = .fullScreen


        let nav = UINavigationController(rootViewController: targetVC)
        window?.rootViewController = nav
//        nav.isNavigationBarHidden = true

//        window?.rootViewController = targetVC


        window?.makeKeyAndVisible()
    }


    func createSpotifyLoginViewController() {
        self.dismissPresentViewController()
        let targetSB = UIStoryboard(name: "SpotifyLogin", bundle: nil)
        let targetVC = targetSB.instantiateViewController(withIdentifier: "SpotifyLoginViewController")

        targetVC.modalPresentationStyle = .fullScreen


        let nav = UINavigationController(rootViewController: targetVC)
//        nav.isNavigationBarHidden = true
        window?.rootViewController = nav

        window?.makeKeyAndVisible()
    }

}

