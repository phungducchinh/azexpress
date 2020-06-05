//
//  MyJobViewController.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/4/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import UIKit

class MyJobViewController: BaseVC {

    @IBOutlet weak var tbvJob: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    func setupView(){
        tbvJob.register(UINib(nibName: "JobContentTbvCell", bundle: nil),
        forCellReuseIdentifier: "JobContentTbvCell")
        tbvJob.delegate = self
        tbvJob.dataSource = self
        
        let insets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)
        tbvJob.contentInset = insets
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
