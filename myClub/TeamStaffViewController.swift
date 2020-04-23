//
//  TeamStaffViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/19.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class TeamStaffViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var teamStaffTable: UITableView!
    var allTeamStaff:[staff] = []
    var selectedTeamStaff:staff = staff(nationality: "", name: "", gender: "", id: 0, type: "", email: "", phone: "")
    var currentCell =  -1
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTeamStaff.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCell.CellStyle.default, reuseIdentifier: "teamStaffCell")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel!.text = allTeamStaff[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCell = indexPath.row
        selectedTeamStaff = allTeamStaff[currentCell]
        performSegue(withIdentifier: "toTeamStaffDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTeamStaffDetails"{
            let secondViewController = segue.destination as! TeamStaffDetailViewController
            
            secondViewController.selectedTeamStaff = self.selectedTeamStaff
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllOtherStaff(completionHandler: {(otherStaff) in
            self.allTeamStaff = otherStaff
            self.teamStaffTable.reloadData()
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
