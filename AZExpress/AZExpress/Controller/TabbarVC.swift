//
//  TabbarVC.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/4/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import UIKit

class TabbarVC: UITabBarController   {
    @IBOutlet weak var tabbar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MyJobViewController
        let myJobVC: MyJobViewController  = MyJobViewController.loadFromNib()
        let myJobIcon = UITabBarItem(title: "MyJob", image: UIImage(named: "ic-home"), selectedImage: UIImage(named: "ic-home.png"))
        myJobVC.tabBarItem = myJobIcon
        let controllers = [myJobVC,myJobVC,myJobVC]  //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabbar.tintColor = UIColor.appColor
//        self.tabbar.unselectedItemTintColor = UIColor.grayText
    }
    

}
