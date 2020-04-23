//
//  AttendanceViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/18.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MAttendanceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var selectedEvent: activity = activity(activityId: 0,date: "",name: "",location: "",type: "",initiatorId: 0,initiatorName: "")
    var attendanceList:[attendanceRec] = []
    var selectedAtt:attendanceRec = attendanceRec(activityName: "", date: "", activityId: 0, state: "", staffId: 0, staffName: "")
 
       
    
    @IBOutlet weak var attendanceTable: UITableView!

    var currentCell = -1

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendanceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCell.CellStyle.value1, reuseIdentifier: "attendanceCell")
        cell.textLabel!.text = attendanceList[indexPath.row].staffName ?? "Tom Lin"
        cell.detailTextLabel!.text = attendanceList[indexPath.row].state
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCell = indexPath.row
        selectedAtt = attendanceList[currentCell]
        performSegue(withIdentifier: "toAttendanceDetail", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "toAttendanceDetail"{
                     let secondViewController = segue.destination as! MAttendanceDetailViewController
                     
                     secondViewController.selectedAtt = self.selectedAtt
    }
    }
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        attendanceTable.reloadData()
    }
    override func viewDidLoad() {
            super.viewDidLoad()
        attendanceTable.reloadData()
            searchAttByActId(activityId: selectedEvent.activityId!, completionHandler:{(attendanceRec) in
                self.attendanceList = attendanceRec
                self.attendanceTable.reloadData()
            })
        }
    
   
    
    
    
}
