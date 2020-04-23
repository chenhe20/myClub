//
//  ChangeEventChooseParticipantTableViewController.swift
//  myClub
//
//  Created by 徐晗超 on 2020/4/22.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MChangeEventChooseParticipantTableViewController: UITableViewController {
    var staffs:[staff] = []
    var selectedStaff:staff = staff(nationality: "", name: "", gender: "", id: 0, type: "", email: "", phone: "")
    @IBOutlet var chooseStaffTable: UITableView!
    
    
    @IBAction func saveButton(_ sender: Any) {
        saveStaff1 = markStaff1
    }
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        chooseStaffTable.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllStaff(completionHandler: {(staff2) in
            self.staffs = staff2
            self.chooseStaffTable.reloadData()
        })
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staffs.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "chooseChangeCell")
          cell?.textLabel!.text = staffs[indexPath.row].name
          return cell!

      }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
                   tableView.cellForRow(at: indexPath)?.accessoryType = .none
               }else{
                   tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

               }
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
                   markStaff1.append(staffs[indexPath.row].id!)
               }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
