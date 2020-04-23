//
//  AccountViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/17.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MAccountViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var job: UILabel!
    @IBOutlet weak var nationality: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
   
    override func viewWillAppear(_ animated: Bool) {
        user?.name = UserDefaults.standard.string(forKey: "name")
        user?.gender = UserDefaults.standard.string(forKey: "gender")
        user?.type = UserDefaults.standard.string(forKey: "job")
        user?.nationality = UserDefaults.standard.string(forKey: "nationality")
        user?.phone = UserDefaults.standard.string(forKey: "phone")
        user?.email = UserDefaults.standard.string(forKey: "email")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = user?.name
        if let staffId = user?.id {
            id.text = String(staffId )
        }
        else{
           id.text = "";
        }
        gender.text = user?.gender
        job.text = user?.type
        nationality.text = user?.nationality
        phone.text = user?.phone
        email.text = user?.email
        

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
