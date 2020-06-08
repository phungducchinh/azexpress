//
//  RegisterVC.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/4/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import UIKit

class RegisterVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onActionLogin(_ sender: Any) {
        onActionOpenLoginView()
    }
    
    @objc func onActionOpenLoginView(){
        let loginVC: LoginVC = LoginVC.loadFromNib()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}
