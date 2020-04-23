//
//  EventDetailViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/17.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    var selectedEvent: activity = activity(activityId: 0,date: "",name: "",location: "",type: "",initiatorId: 0,initiatorName: "")
    var attendanceList:[attendanceRec] = []
    var allParticipants:[String] = []

    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventTimeDetail: UILabel!
    @IBOutlet weak var eventVenueDetail: UILabel!
    @IBOutlet weak var eventTypeDetail: UILabel!
    @IBOutlet weak var eventInitiatorDetail: UILabel!
    @IBOutlet weak var eventParticipantDetail: UILabel!
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
