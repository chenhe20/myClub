//
//  TeamPlayerViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/19.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class TeamPlayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var allTeamPlayersTable: UITableView!
    var allTeamPlayers:[staff] = []
    var selectedTeamPlayer:staff = staff(nationality: "", name: "", gender: "", id: 0, type: "", email: "", phone: "")
    var currentCell =  -1
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTeamPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCell.CellStyle.default, reuseIdentifier: "teamPlayerCell")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel!.text = allTeamPlayers[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCell = indexPath.row
        selectedTeamPlayer = allTeamPlayers[currentCell]
        performSegue(withIdentifier: "toTeamPlayerDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTeamPlayerDetails"{
            let secondViewController = segue.destination as! TeamPlayerDetailViewController
            
            secondViewController.selectedTeamPlayer = self.selectedTeamPlayer
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        getAllplayer(completionHandler: {(teamPlayers) in
            self.allTeamPlayers = teamPlayers
            self.allTeamPlayersTable.reloadData()
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
