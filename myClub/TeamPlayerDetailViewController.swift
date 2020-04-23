//
//  TeamPlayerDetailViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/19.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class TeamPlayerDetailViewController: UIViewController {

    @IBOutlet weak var teamPlayerNameDetail: UILabel!
    @IBOutlet weak var teamPlayerGenderDetail: UILabel!
    @IBOutlet weak var teamPlayerJobDetail: UILabel!
    @IBOutlet weak var teamPlayerNationalityDetail: UILabel!
    @IBOutlet weak var teamPlayerPhoneDetail: UILabel!
    @IBOutlet weak var teamPlayerEmailDetail: UILabel!
    
    var selectedTeamPlayer:staff = staff(nationality: "", name: "", gender: "", id: 0, type: "", email: "", phone: "")
    
    override func viewDidLoad() {
        teamPlayerNameDetail.text = selectedTeamPlayer.name
        teamPlayerGenderDetail.text = selectedTeamPlayer.gender
        teamPlayerJobDetail.text = selectedTeamPlayer.type
        teamPlayerNationalityDetail.text = selectedTeamPlayer.nationality
        teamPlayerPhoneDetail.text = selectedTeamPlayer.phone
        teamPlayerEmailDetail.text = selectedTeamPlayer.email
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
