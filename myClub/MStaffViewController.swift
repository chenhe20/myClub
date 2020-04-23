//
//  StaffViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/17.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit



class MStaffViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var staffTable: UITableView!
    var allStaff:[staff] = []
     var selectedStaff:staff = staff(nationality: "", name: "", gender: "", id: 0, type: "", email: "", phone: "")
     var currentCell =  -1
     var searchStaff:[staff] = []
     var searching = false
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if searching{
             return searchStaff.count
         }else{
             return allStaff.count
         }
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = UITableViewCell(style:UITableViewCell.CellStyle.subtitle, reuseIdentifier: "eventCell")
         cell.accessoryType = .disclosureIndicator
         if searching{
             cell.textLabel!.text = searchStaff[indexPath.row].name
             cell.detailTextLabel!.text = searchStaff[indexPath.row].type
         }else{
             cell.textLabel!.text = allStaff[indexPath.row].name
             cell.detailTextLabel!.text = allStaff[indexPath.row].type
         }
         return cell
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         currentCell = indexPath.row
         if searching{
             selectedStaff = searchStaff[currentCell]
         }else{
             selectedStaff = allStaff[currentCell]
         }
         performSegue(withIdentifier: "toStaffDetails", sender: nil)
     }
     
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         searchStaff = allStaff.filter({$0.name!.lowercased().prefix(searchText.count) == searchText.lowercased()||$0.type!.lowercased().prefix(searchText.count) == searchText.lowercased()})
         searching = true
         staffTable.reloadData()
     }
     
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         searching = false
         searchBar.text = ""
         self.view.endEditing(true)
         staffTable.reloadData()
     }
     
     
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "toStaffDetails"{
             let secondViewController = segue.destination as! MStaffDetailViewController
             secondViewController.selectedStaff = self.selectedStaff
         }
     }
     override func viewWillAppear(_ animated: Bool) {
         viewDidLoad()
         staffTable.reloadData()
     }
    @IBAction func unwindtoStaff(_ sender: UIStoryboardSegue){
           
       }
     override func viewDidLoad() {
         super.viewDidLoad()
         getAllStaff(completionHandler: {(staffs) in
             self.allStaff = staffs
             self.staffTable.reloadData()
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
