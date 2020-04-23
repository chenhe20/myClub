//
//  AttendanceDetailViewController.swift
//  myClub
//
//  Created by 徐晗超 on 2020/4/20.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MAttendanceDetailViewController: UIViewController {
     var selectedAtt:attendanceRec = attendanceRec(activityName: "", date: "", activityId: 0, state: "", staffId: 0, staffName: "")

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    
    @IBOutlet weak var staffname: UILabel!
    
    @IBOutlet weak var staffid: UILabel!

    
    @IBOutlet weak var status: UILabel!
    
    

        override func viewDidLoad() {
        super.viewDidLoad()
        
        let eventid = String(selectedAtt.activityId!)
        let staff_id = String(selectedAtt.staffId!)
        
        name.text = selectedAtt.activityName
        id.text = eventid
        date.text = detailedTimeFormatter(date: selectedAtt.date!)
        staffname.text = selectedAtt.staffName
        staffid.text = staff_id
        status.text = selectedAtt.state
  

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChangeStatus"{
                              let secondViewController = segue.destination as! MChangeAttendanceDetailViewController
                              
                              secondViewController.selectedAtt = self.selectedAtt
        
    }
   /*    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
