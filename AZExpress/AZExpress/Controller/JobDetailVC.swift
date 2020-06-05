//
//  JobDetailVC.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/5/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import UIKit

class JobDetailVC: BaseVC {
    
    @IBOutlet weak var btnCapture: UIButton!
    @IBOutlet weak var vwFinish: UIView!
    @IBOutlet weak var lblDescript: UILabel!
    @IBOutlet weak var imv: UIImageView!
    @IBOutlet weak var vwStackDate: UIStackView!
    
    var jobType = JobType.new
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settupView()
    }
    
    func settupView(){
        self.title = "Thông tin công việc"
        btnCapture.setShadow(color: UIColor.black.withAlphaComponent(0.20), x: 0, y: 2, blur: 4)
        switch jobType {
        case .new:
            self.vwFinish.isHidden = true
            self.imv.isHidden = true
            self.lblDescript.isHidden = false
            self.btnCapture.isHidden = false
            self.vwStackDate.isHidden = true
        case .finish:
            self.vwFinish.isHidden = false
            self.imv.isHidden = false
            self.lblDescript.isHidden = true
            self.btnCapture.isHidden = true
            self.vwStackDate.isHidden = false
        }
    }
    
    @IBAction func onActionCapture(_ sender: Any) {
    }
}
