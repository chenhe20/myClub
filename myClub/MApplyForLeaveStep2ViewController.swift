//
//  ApplyForLeaveStep2ViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/18.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MApplyForLeaveStep2ViewController: UIViewController {
    var selectedApply:attendanceRec = attendanceRec(activityName: "", date: "", activityId: 0, state: "", staffId: 0, staffName: "")
    
    
    
    
    @IBAction func approveButton(_ sender: Any) {
        modifyAttRec(staffId: selectedApply.staffId!, activityId: selectedApply.activityId!, state: "Leave", completionHandler: {(success) in
            
            guard success == true else{
                let prompt = UIAlertController(title: "Approve Failed", message: "Your approve failed.Please try it again", preferredStyle: .alert)
                prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                    action in
                    self.viewDidLoad()
                }))
                self.present(prompt,animated: true)
                print("Approve fail")
                return
            }
            let prompt = UIAlertController(title: "Approve Succeed", message: "Your approve success.", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
                
            }))
            self.present(prompt,animated: true)
            print("Approve success")
            
        })
        
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        event.text = selectedApply.activityName
        staff.text = selectedApply.staffName
        
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var event: UILabel!
    
    @IBOutlet weak var staff: UILabel!
    
    
    /*    // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
