//
//  EventViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/16.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MEventViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var eventTable: UITableView!
    var events:[activity] = []
    var selectedEvent:activity = activity(activityId: 0,date: "",name: "",location: "",type: "",initiatorId: 0,initiatorName: "")
       var currentCell =  -1
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return events.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = UITableViewCell(style:UITableViewCell.CellStyle.default, reuseIdentifier: "eventCell")
           cell.accessoryType = .disclosureIndicator
           cell.textLabel!.text = events[indexPath.row].name
           return cell
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           currentCell = indexPath.row
           selectedEvent = events[currentCell]
           performSegue(withIdentifier: "toEventDetail", sender: nil)
       }
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toEventDetail"{
               let secondViewController = segue.destination as! MEventDetailViewController
               
               secondViewController.selectedEvent = self.selectedEvent
           }
           
       }
 
    @IBAction func unwindtoEvent(_ sender: UIStoryboardSegue){
        
    }
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        eventTable.reloadData()
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getAllActivities(completionHandler: {(activities) in
            
            self.events = activities
            self.eventTable.reloadData()
            print(self.events)
        
        
//        getRecentActivities(completionHandler: { (activities) in
//            self.events = activities
//            self.eventTable.reloadData()
//            print(self.events)
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

