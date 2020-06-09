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
    var jobData = JobDataModel()
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
    
    func setData(jobData: JobDataModel){
        self.jobData = jobData
        self.jobType = jobData.status == "New" ? .new : .finish
        
        var status = ""
        switch self.jobType {
        case .new:
            vwBgStatus.backgroundColor = UIColor.appColor
            status = "Mới"
        case .finish:
            vwBgStatus.backgroundColor = UIColor.greenColor
            status = "Hoàn thành"
        }
        
        self.lblStatus.text = "Mã QRCode: \(jobData.task_code ?? "") - \(jobData.district ?? "") - \(status)"
        self.lblName.text = "Phạm Trần Huy Hợp"
        self.lblPhone.text = jobData.phone ?? ""
        self.lblAddress.text = jobData.address ?? ""
        
        vwBg.setShadow(color: UIColor.black.withAlphaComponent(0.20), x: 0, y: 4, blur: 4)
        vwBgStatus.layer.cornerRadius = 10
        vwBgStatus.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
