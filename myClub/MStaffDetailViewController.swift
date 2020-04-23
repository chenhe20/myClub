//
//  StaffDetailViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/17.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MStaffDetailViewController: UIViewController {
    var selectedStaff:staff = staff(nationality: "", name: "", gender: "", id: 0, type: "", email: "", phone: "")

    @IBOutlet weak var staffNameDetail: UILabel!
    
    @IBOutlet weak var staffGenderDetail: UILabel!
    
    @IBOutlet weak var staffJobDetail: UILabel!
    
    @IBOutlet weak var staffNationalityDetail: UILabel!
    
    @IBOutlet weak var staffPhoneDetail: UILabel!
    
    @IBOutlet weak var staffEmailDetail: UILabel!
    override func viewDidLoad() {
        staffNameDetail.text = selectedStaff.name
        staffGenderDetail.text = selectedStaff.gender
        staffJobDetail.text = selectedStaff.type
        staffNationalityDetail.text = selectedStaff.nationality
        staffPhoneDetail.text = selectedStaff.phone
        staffEmailDetail.text = selectedStaff.email
        
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
