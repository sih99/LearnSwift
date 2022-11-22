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
import FirebaseFirestore
import FirebaseFirestoreSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //Firebase 초기화
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self

//        let db = Firestore.firestore()
//
//        db.collection("creditCardList").getDocuments { snapshot, _ in
//            guard snapshot?.isEmpty == true else { return }
//
//            let batch = db.batch()
//            let card0Ref = db.collection("creditCardList").document("card0")
//            let card1Ref = db.collection("creditCardList").document("card1")
//            let card2Ref = db.collection("creditCardList").document("card2")
//            let card3Ref = db.collection("creditCardList").document("card3")
//            let card4Ref = db.collection("creditCardList").document("card4")
//            let card5Ref = db.collection("creditCardList").document("card5")
//            let card6Ref = db.collection("creditCardList").document("card6")
//
//            do {
//                try batch.setData(from: CreditCardDummy.card0, forDocument: card0Ref)
//                try batch.setData(from: CreditCardDummy.card1, forDocument: card1Ref)
//                try batch.setData(from: CreditCardDummy.card2, forDocument: card2Ref)
//                try batch.setData(from: CreditCardDummy.card3, forDocument: card3Ref)
//                try batch.setData(from: CreditCardDummy.card4, forDocument: card4Ref)
//                try batch.setData(from: CreditCardDummy.card5, forDocument: card5Ref)
//                try batch.setData(from: CreditCardDummy.card6, forDocument: card6Ref)
//            } catch let error {
//                print("Error writing card to Firestore \(error.localizedDescription)")
//            }
//            
//            batch.commit()
//
//        }

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

    func createCreditCardListViewController() {
        self.dismissPresentViewController()
        let targetSB = UIStoryboard(name: "CreditCardList", bundle: nil)
        let targetVC = targetSB.instantiateViewController(withIdentifier: "CardListViewController")

        targetVC.modalPresentationStyle = .fullScreen


        let nav = UINavigationController(rootViewController: targetVC)
//        nav.isNavigationBarHidden = true
        window?.rootViewController = nav

        window?.makeKeyAndVisible()
    }



}

