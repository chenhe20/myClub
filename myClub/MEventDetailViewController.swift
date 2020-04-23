//
//  EventDetailViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/17.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MEventDetailViewController: UIViewController {
    var selectedEvent: activity = activity(activityId: 0,date: "",name: "",location: "",type: "",initiatorId: 0,initiatorName: "")
    var attendanceList:[attendanceRec] = []
    var allParticipants:[String] = []

    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventTimeDetail: UILabel!
    @IBOutlet weak var eventVenueDetail: UILabel!
    @IBOutlet weak var eventTypeDetail: UILabel!
    @IBOutlet weak var eventInitiatorDetail: UILabel!
    @IBOutlet weak var eventParticipantDetail: UILabel!
    
    @IBAction func cancelEvent(_ sender: Any) {
        deleteActivity(activityId: selectedEvent.activityId!, completionHandler: {(success) in
            
            
            guard success == true else{
                          let prompt = UIAlertController(title: "Delete Failed", message: "Your delete failed. Please delete again", preferredStyle: .alert)
                        prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                            action in
                            self.viewDidLoad()
                                                                    }))
                                                    self.present(prompt,animated: true)
                                                    print("Delete fail")
                                                    return
                          
                          
                      }
            
            let prompt = UIAlertController(title: "Delete Succeed", message: "You have already deleted an event", preferredStyle: .alert)
                                      prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                                          action in
                                          self.viewDidLoad()
                                      }))
                                      self.present(prompt,animated: true)
                                      print("Delete succeed")
                                      return
            
            
        })
    
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        eventTitle.text = selectedEvent.name
        eventTimeDetail.text = detailedTimeFormatter(date: selectedEvent.date!)
        eventVenueDetail.text = selectedEvent.location
        eventTypeDetail.text = selectedEvent.type
        eventInitiatorDetail.text = selectedEvent.initiatorName
        
        
        
        searchAttByActId(activityId: selectedEvent.activityId!, completionHandler: { (attendanceRecs) in
            self.attendanceList = attendanceRecs
            for attendanceEntry in self.attendanceList{
                self.allParticipants.append(attendanceEntry.staffName ?? "")
            }
            var participants = ""
            for participant in self.allParticipants{
                participants = participants + participant+"/"
            }
            self.eventParticipantDetail.text = "\(participants)"
        })

        

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAttendance"{
                     let secondViewController = segue.destination as! MAttendanceViewController
                     
                     secondViewController.selectedEvent = self.selectedEvent
    }
        if segue.identifier == "toChangeEvent"{
                            let secondViewController = segue.destination as! MChangeEventDetailViewController
                            
                            secondViewController.selectedEvent = self.selectedEvent
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
}
