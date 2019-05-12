//
//  StudentTableViewController.swift
//  On the Map
//
//  Created by Reem on 5/10/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import UIKit

class StudentTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.delegate = self
        self.tableView.reloadData()

    }
    
   
    
}

extension StudentTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentModel.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "StudentCell")
        let students = StudentModel.students[indexPath.row]
        
        cell.textLabel?.text = "\(students.firstName ?? "") \(students.lastName ?? "")"
        cell.detailTextLabel?.text = students.mediaURL
        cell.imageView?.image = UIImage(named: "location")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
      let students = StudentModel.students[indexPath.row]
        UIApplication.shared.open(URL(string: students.mediaURL!)!, options: [:], completionHandler: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
