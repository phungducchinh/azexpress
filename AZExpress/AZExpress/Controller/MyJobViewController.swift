//
//  MyJobViewController.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/4/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import UIKit
import JKCalendar
import SVProgressHUD
import Alamofire

public enum JKCalendarMarkType{
    case circle
    case hollowCircle
    case underline
    case dot
}

class MyJobViewController: BaseVC {

    @IBOutlet weak var tbvJob: UITableView!
    @IBOutlet weak var vwCalendar: JKCalendar!
    var jobVM =  JobViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }

    func getData(){
        SVProgressHUD.show()
        self.tbvJob.isHidden = true
        jobVM.getAllJobListData(onCompletion: {data in
            guard let data = data else{
                SVProgressHUD.dismiss()
                Alert.shared.showInfo(title: "", message: "Có lỗi xảy ra. Vui lòng thử lại", on: self, callback: nil)
                return
            }
            self.jobVM.addJobListData(data: data)
            self.tbvJob.reloadData()
            self.tbvJob.isHidden = false
            SVProgressHUD.dismiss()
        }, onError: {error in
            SVProgressHUD.dismiss()
            Alert.shared.showInfo(title: "", message: error.messages, on: self, callback: nil)
        })
    }
    
    func setupView(){
        tbvJob.register(UINib(nibName: "JobContentTbvCell", bundle: nil),
        forCellReuseIdentifier: "JobContentTbvCell")
        tbvJob.delegate = self
        tbvJob.dataSource = self
        
        let insets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)
        tbvJob.contentInset = insets
        vwCalendar.dataSource = self
        vwCalendar.delegate = self
        vwCalendar.isNearbyMonthNameDisplayed = false
//        vwCalendar.ca
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
        return self.jobVM.jobList.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobContentTbvCell", for: indexPath) as! JobContentTbvCell
        if let data = self.jobVM.jobList.data?[indexPath.row]{
            cell.setData(jobData: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: JobContentTbvCell = tableView.cellForRow(at: indexPath) as! JobContentTbvCell
        let jobDetailVC: JobDetailVC = JobDetailVC.loadFromNib()
        jobDetailVC.jobType = cell.jobType//data.status == "New" ? .new : .finish
        jobDetailVC.jobID = cell.jobData.task_code ?? ""
        self.presentViewController(jobDetailVC, animated: true)
    }
}

//-MARK: Setup calendar
extension MyJobViewController: JKCalendarDataSource{
    func calendar(_ calendar: JKCalendar, marksWith month: JKMonth) -> [JKCalendarMark]? {
        let today = JKDay(date: Date())
        if today == month{
            return [JKCalendarMark(type: .dot, day: today, color: .appColor)]
        }else{
            return nil
        }
    }
}

extension MyJobViewController: JKCalendarDelegate{
    func calendar(_ calendar: JKCalendar, didTouch day: JKDay) {
        print(day.date as Any)
    }
}
