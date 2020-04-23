//
//  TeamPlayerDetailViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/19.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MTeamPlayerDetailViewController: UIViewController {

    @IBOutlet weak var teamPlayerNameDetail: UILabel!
    @IBOutlet weak var teamPlayerGenderDetail: UILabel!
    @IBOutlet weak var teamPlayerJobDetail: UILabel!
    @IBOutlet weak var teamPlayerNationalityDetail: UILabel!
    @IBOutlet weak var teamPlayerPhoneDetail: UILabel!
    @IBOutlet weak var teamPlayerEmailDetail: UILabel!
    
    var selectedTeamPlayer:staff = staff(nationality: "", name: "", gender: "", id: 0, type: "", email: "", phone: "")

    @IBAction func deletePlayerButton(_ sender: Any) {
        deleteStaff(id: selectedTeamPlayer.id!, completionHandler: {(success) in
            let prompt = UIAlertController(title: "Delete Succeed", message: "You have already deleted this staff", preferredStyle: .alert)
                           prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                               action in
                               self.viewDidLoad()
                           }))
                           self.present(prompt,animated: true)
                           print("delete success")
                           return
            
        })
    }
    
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toChangePlayerDetail"{
               let secondViewController = segue.destination as! MChangePlayerDetailViewController
               
               secondViewController.selectedTeamPlayer = self.selectedTeamPlayer
           }
    


}
}
