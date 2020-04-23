//
//  ChangeAttendanceDetailViewController.swift
//  myClub
//
//  Created by 徐晗超 on 2020/4/20.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MChangeAttendanceDetailViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    let status = ["Present","Absent","Leave","Injured","Waiting","Applying"]
     var selectedAtt:attendanceRec = attendanceRec(activityName: "", date: "", activityId: 0, state: "", staffId: 0, staffName: "")
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return status[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return status.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAtt.state = status[row]
    }
    
    @IBAction func saveButton(_ sender: Any) {
        modifyAttRec(staffId: selectedAtt.staffId!, activityId: selectedAtt.activityId!, state: selectedAtt.state!, completionHandler: {(success) in
            
            let prompt = UIAlertController(title: "Change Succeed", message: "You have already changed this attendance state", preferredStyle: .alert)
                                                 prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                                                     action in
                                                     self.viewDidLoad()
                                                 }))
                                                 self.present(prompt,animated: true)
                                                 print("Change succeed")
                                                 return
            
            
            
            
        })
    }
    
    

    override func viewDidLoad() {
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
