//
//  DateClvCell.swift
//  beaudy
//
//  Created by TaNhi on 8/14/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

protocol DateClvCellDelegate: class {
    func dateClvCell (cell: DateClvCell, didSelected index: Int);
}

enum DateJobStatus {
    case normal
    case hightlight
    case selected
}

class DateClvCell: UICollectionViewCell {
    @IBOutlet weak var dayOfTheWeekLabel: UILabel!
    @IBOutlet weak var backgroundOfDayView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    
    weak var delegate: DateClvCellDelegate?;
    var jobStatus: DateJobStatus = .normal {
        didSet {
            switch jobStatus  {
            case .normal:
                dayLabel.backgroundColor = .clear
                dayLabel.textColor = .lightGray
            case .hightlight:
                dayLabel.backgroundColor = .clear
                dayLabel.textColor = .black
            case .selected:
                dayLabel.backgroundColor = UIColor(hex: 0xF47320)
                dayLabel.textColor = .white
            default:
                break
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()

    }
    
    func initUI() {
        self.dayLabel.setRoundary(radius: dayLabel.frame.height/2)
    }
}
