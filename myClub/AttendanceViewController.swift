//
//  AttendanceViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/18.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class AttendanceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var attendanceTable: UITableView!
    @IBOutlet weak var monthInput: UITextField!
    @IBOutlet weak var yearInput: UITextField!
    @IBOutlet weak var attendedDetail: UILabel!
    @IBOutlet weak var absentDetail: UILabel!
    @IBOutlet weak var leaveDetail: UILabel!
    @IBOutlet weak var rateDetail: UILabel!
    
    var events:[attendanceRec] = []
    var attPresented = 0.0
    var attAbsent = 0.0
    var attLeave = 0.0
    var month = ""
    var year = ""
    var validatedMonth = ""
    var attRate = 0.00
    
    func attDisplay(){
        for attendanceState in events{
            if attendanceState.state == "Present"{
                attPresented = attPresented + 1
            }else if attendanceState.state == "Absent"{
                attAbsent = attAbsent + 1
            }else if attendanceState.state == "Injured"||attendanceState.state == "Leave"{
                attLeave = attLeave + 1
            }
        }
        
        if attPresented+attAbsent+attLeave == 0{
            attRate = 0
        }else{
            attRate = Double(attPresented/(attPresented+attAbsent+attLeave))
        }
        attendedDetail.text = String(Int(attPresented))
        absentDetail.text = String(Int(attAbsent))
        leaveDetail.text = String(Int(attLeave))
        rateDetail.text = String(format:"%.2f",attRate)
    }

    @IBAction func searchRecord(_ sender: Any) {
        
        if validateMonth(monthInput: monthInput.text!)&&validateYear(yearInput: yearInput.text!){
            month = monthInput.text!
            year = yearInput.text!
            validatedMonth = year+"/"+month
        }else{
            let prompt = UIAlertController(title: "Wrong input!", message: "Check your Month/Year input", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
            }))
            self.present(prompt,animated: true)
        }
        searchAttByMonth(staffId: user?.id ?? 1, month:validatedMonth, completionHandler: {(attendanceRecs) in
            self.events = attendanceRecs
            self.attendanceTable.reloadData()
            self.attDisplay()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCell.CellStyle.value1, reuseIdentifier: "attendanceCell")
        cell.textLabel!.text = events[indexPath.row].activityName
        cell.detailTextLabel!.text = events[indexPath.row].state
        
        return cell
    }
    
    override func viewDidLoad() {
        self.HideKeyboard()
        super.viewDidLoad()
        
        
        

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
