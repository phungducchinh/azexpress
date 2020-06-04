//
//  LoginVC.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/4/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onActionLogin(_ sender: Any) {
        let tabbarVC: TabbarVC = TabbarVC.loadFromNib()
        self.navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    @IBAction func onActionRegister(_ sender: Any) {
        onActionOpenRegisterView()
    }
    
    
    
    @objc func onActionOpenRegisterView(){
        let registerVC: RegisterVC = RegisterVC.loadFromNib()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}
