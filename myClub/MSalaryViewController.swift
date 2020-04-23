//
//  SalaryViewController.swift
//  myClub
//
//  Created by 徐晗超 on 2020/4/21.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MSalaryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var salaryTable: UITableView!
    var wage:[monthlyWage] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "salaryCell")
       
        cell.textLabel!.text = wage[indexPath.row].staffName
        
         
        cell.detailTextLabel!.text = String(wage[indexPath.row].total!)
        return cell
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        salaryTable.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllWage(completionHandler: {(wages) in
            self.wage = wages
            self.salaryTable.reloadData()
        })

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
