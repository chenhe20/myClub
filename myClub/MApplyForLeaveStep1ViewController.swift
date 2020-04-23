//
//  ApplyForLeaveStep1ViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/18.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MApplyForLeaveStep1ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
 
    @IBOutlet weak var applyTable: UITableView!
    var leaveApply:[attendanceRec] = []
    var selectedApply:attendanceRec = attendanceRec(activityName: "", date: "", activityId: 0, state: "", staffId: 0, staffName: "")
    
    
    var currentCell =  -1
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaveApply.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCell.CellStyle.subtitle, reuseIdentifier: "eventCell")
        cell.textLabel!.text = leaveApply[indexPath.row].staffName
        cell.detailTextLabel!.text = leaveApply[indexPath.row].activityName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCell = indexPath.row
        selectedApply = leaveApply[currentCell]
        performSegue(withIdentifier: "toApprove", sender: nil)

        }
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toApprove"{
                    let secondViewController = segue.destination as! MApplyForLeaveStep2ViewController
                    
                    secondViewController.selectedApply = self.selectedApply
                }
    }
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        applyTable.reloadData()
 
    }
    override func viewDidLoad() {
          super.viewDidLoad()
          viewLeaveApply(completionHandler: {(attendance) in
            self.leaveApply = attendance
            self.applyTable.reloadData()
              
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
