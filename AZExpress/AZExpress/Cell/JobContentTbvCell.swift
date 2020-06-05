//
//  JobContentTbvCell.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/5/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import UIKit

class JobContentTbvCell: UITableViewCell {

    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var vwBgStatus: UIView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    var jobType = JobType.new
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(uiType: JobType){
        jobType = uiType
        
        vwBg.setShadow(color: UIColor.black.withAlphaComponent(0.20), x: 0, y: 4, blur: 4)
        vwBgStatus.layer.cornerRadius = 10
        vwBgStatus.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        switch uiType {
        case .new:
            vwBgStatus.backgroundColor = UIColor.appColor
        case .finish:
            vwBgStatus.backgroundColor = UIColor.greenColor
        }
    }
}
