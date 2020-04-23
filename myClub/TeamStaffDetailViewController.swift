//
//  TeamStaffDetailViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/19.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class TeamStaffDetailViewController: UIViewController {

    @IBOutlet weak var teamStaffNameDetail: UILabel!
    @IBOutlet weak var teamStaffGenderDetail: UILabel!
    @IBOutlet weak var teamStaffJobDetail: UILabel!
    @IBOutlet weak var teamStaffNationalityDetail: UILabel!
    @IBOutlet weak var teamStaffPhoneDetail: UILabel!
    @IBOutlet weak var teamStaffEmailDetail: UILabel!
    
    var selectedTeamStaff:staff = staff(nationality: "", name: "", gender: "", id: 0, type: "", email: "", phone: "")
    
    override func viewDidLoad() {
        teamStaffNameDetail.text = selectedTeamStaff.name
        teamStaffGenderDetail.text = selectedTeamStaff.gender
        teamStaffJobDetail.text = selectedTeamStaff.type
        teamStaffNationalityDetail.text = selectedTeamStaff.nationality
        teamStaffPhoneDetail.text = selectedTeamStaff.phone
        teamStaffEmailDetail.text = selectedTeamStaff.email
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
