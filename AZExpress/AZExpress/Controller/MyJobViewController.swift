//
//  MyJobViewController.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/4/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import UIKit
import JKCalendar


public enum JKCalendarMarkType{
    case circle
    case hollowCircle
    case underline
    case dot
}

class MyJobViewController: BaseVC {
    let identifierDateClvCell = "DateClvCell"
    
    @IBOutlet weak var tbvJob: UITableView!
    @IBOutlet weak var vwCalendar: UIView!
    @IBOutlet weak var monthYearLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var clvCalendar: UICollectionView!
    
    var dayOfTheWeekList = ["CN", "T2", "T3","T4","T5","T6", "T7"]
    var workingDate = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]
    var indexDate = 5
    var monthDisplay = 6
    var year = 2020
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    func setupView(){
        clvCalendar.register(UINib(nibName: identifierDateClvCell, bundle: nil), forCellWithReuseIdentifier: identifierDateClvCell);

        tbvJob.register(UINib(nibName: "JobContentTbvCell", bundle: nil),
        forCellReuseIdentifier: "JobContentTbvCell")
        tbvJob.delegate = self
        tbvJob.dataSource = self
        
        let insets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)
        tbvJob.contentInset = insets
        
        clvCalendar.contentInset.left = 10;
        clvCalendar.contentInset.right = 10;
    }
}

extension MyJobViewController {
    @IBAction func onTappedNextMonth(_ sender: Any) {
        guard monthDisplay < 12 else {return}
        monthDisplay += 1
        showMonth()
    }
    
    @IBAction func onTappedBackMonth(_ sender: Any) {
        guard monthDisplay > 1 else {return}
        monthDisplay += -1
        showMonth()
    }
    
    func showMonth() {
        self.monthYearLabel.text = "Tháng \(monthDisplay)"
    }

}

//-MARK: UITableViewDelegate
extension MyJobViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//-MARK: UITableViewDatasource
extension MyJobViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobContentTbvCell", for: indexPath) as! JobContentTbvCell
        cell.setupView(uiType: indexPath.row % 2 == 0 ? JobType.new : JobType.finish)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: JobContentTbvCell = tableView.cellForRow(at: indexPath) as! JobContentTbvCell
        let jobDetailVC: JobDetailVC = JobDetailVC.loadFromNib()
        jobDetailVC.jobType = cell.jobType
        self.presentViewController(jobDetailVC, animated: true)
        
    }
}


extension MyJobViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workingDate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = clvCalendar.dequeueReusableCell(withReuseIdentifier: identifierDateClvCell, for: indexPath) as! DateClvCell
        let dateDisplay = workingDate[indexPath.row]
        if indexDate ==  indexPath.item {
            cell.jobStatus = .selected
        } else {
            if dateDisplay < 10 {
                cell.jobStatus = .normal
            } else {
                cell.jobStatus = .hightlight
            }
        }
        
        cell.dayOfTheWeekLabel.text = dayOfTheWeekList[indexPath.item % 7]
        
        cell.dayLabel.text = "\(dateDisplay)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.indexDate = indexPath.item
        clvCalendar.reloadData()
    }
    
    
}

extension MyJobViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 45, height: 70);
    }
}

//-MARK: Setup calendar
//extension MyJobViewController: JKCalendarDataSource{
//    func calendar(_ calendar: JKCalendar, marksWith month: JKMonth) -> [JKCalendarMark]? {
//        let today = JKDay(date: Date())
//        if today == month{
//            return [JKCalendarMark(type: .dot, day: today, color: .appColor)]
//        }else{
//            return nil
//        }
//    }
//}
//
//extension MyJobViewController: JKCalendarDelegate{
//    func calendar(_ calendar: JKCalendar, didTouch day: JKDay) {
//        print(day.date as Any)
//    }
//}
