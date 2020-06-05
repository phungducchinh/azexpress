//
//  MyAccountVC.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/5/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import UIKit

class MyAccountVC: BaseVC {

    @IBOutlet weak var vwBgFiltter: UIView!
    @IBOutlet weak var btnDay: UIButton!
    @IBOutlet weak var btnWeek: UIButton!
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet weak var btnMore: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settupView()
        // Do any additional setup after loading the view.
    }
    
    func settupView(){
        vwBgFiltter.setShadow(color: UIColor.black.withAlphaComponent(0.20), x: 0, y: 2, blur: 4)
        btnDay.setBorder(color: .appColor, lineW: 1.0)
        btnWeek.setBorder(color: .borderBtn, lineW: 1.0)
        btnMonth.setBorder(color: .borderBtn, lineW: 1.0)
        btnMore.setBorder(color: .borderBtn, lineW: 1.0)
    }
}
