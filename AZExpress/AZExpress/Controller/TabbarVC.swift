//
//  TabbarVC.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/4/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import UIKit

class TabbarVC: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MyJobViewController
        let myJobVC: MyJobViewController  = MyJobViewController.loadFromNib()
        let myJobIcon = UITabBarItem(title: "Công việc", image: UIImage(named: "ic-home"), selectedImage: UIImage(named: "ic_home_selected"))
        myJobVC.tabBarItem = myJobIcon
        
        let qrVC: ScanQRCodeVC = ScanQRCodeVC.loadFromNib()
        let qrIcon = UITabBarItem(title: "Quét QRcode", image: UIImage(named: "ic_scan"), selectedImage: UIImage(named: "ic_QRcode_selected"))
        qrVC.tabBarItem = qrIcon
        
        let accVC: MyAccountVC  = MyAccountVC.loadFromNib()
        let accIcon = UITabBarItem(title: "Cá nhân", image: UIImage(named: "ic_user"), selectedImage: UIImage(named: "ic_account_selected"))
        accVC.tabBarItem = accIcon
        
        let controllers = [myJobVC,qrVC,accVC]  //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers
        UITabBar.appearance().tintColor = UIColor.appColor
        UITabBar.appearance().backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabbar.tintColor = UIColor.appColor
//        self.tabbar.unselectedItemTintColor = UIColor.grayText
    }
    

}
