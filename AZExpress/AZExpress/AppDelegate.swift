//
//  AppDelegate.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/4/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let loginVC: LoginVC = LoginVC.loadFromNib()
        
        FirebaseApp.configure()
        let registerVC: RegisterVC = RegisterVC.loadFromNib()
        let navVC: UINavigationController = UINavigationController.init(rootViewController: registerVC)
        registerVC.navigationController?.isNavigationBarHidden = true
        window?.rootViewController = navVC
        setupIQKeyboard()
        return true
    }
    
    func setupIQKeyboard() {
        IQKeyboardManager.shared.enable = true
        //        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
//        IQKeyboardManager.shared.disabledDistanceHandlingClasses.append(ChatViewController.self)
    }
}

