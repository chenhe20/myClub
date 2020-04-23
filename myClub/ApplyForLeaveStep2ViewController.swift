//
//  ApplyForLeaveStep2ViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/18.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class ApplyForLeaveStep2ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var leaveTypePicker: UIPickerView!
    
    let leaveType = ["Personal Leave","Injury Leave","Other"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return leaveType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return leaveType.count
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
