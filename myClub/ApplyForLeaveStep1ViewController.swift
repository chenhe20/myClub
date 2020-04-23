//
//  ApplyForLeaveStep1ViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/18.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class ApplyForLeaveStep1ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    

    @IBOutlet weak var step1Table: UITableView!
    @IBOutlet weak var eventChoice: UILabel!
    
    var events:[attendanceRec] = []
    var selectedEvent:attendanceRec = attendanceRec(activityName: "", date: "", activityId: 0, state: "", staffId: 0, staffName: ""
    )
    var currentCell =  -1
    
    @IBAction func submitButton(_ sender: Any) {
        if selectedEvent.activityId == 0 {
            let prompt = UIAlertController(title: "Application Failed", message: "Please select event", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
            }))
            self.present(prompt,animated: true)
            print("Application Failed")
            return
        }
        applyForLeave(staffId: user!.id!, activityId: selectedEvent.activityId!, completionHandler: {(success) in
            guard success == true else{
                //Application Failed
                let prompt = UIAlertController(title: "Application Failed", message: "You have taken two events off this month", preferredStyle: .alert)
                prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                    action in
                    self.viewDidLoad()
                }))
                self.present(prompt,animated: true)
                print("Application Failed")
                return
            }
            //Application Approved
            let prompt = UIAlertController(title: "Application Approved", message: "The manager will be notified", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
            }))
            self.present(prompt,animated: true)
            print("Application Approved")
            return
            
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCell.CellStyle.subtitle, reuseIdentifier: "eventCell")
        cell.textLabel!.text = events[indexPath.row].activityName
        cell.detailTextLabel!.text = detailedTimeFormatter(date: events[indexPath.row].date!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCell = indexPath.row
        selectedEvent = events[currentCell]
        eventChoice.text = selectedEvent.activityName
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchAttByStaffId(staffId: user?.id ?? 0, completionHandler: {(attendanceRecs) in
            self.events = attendanceRecs
            self.step1Table.reloadData()
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
