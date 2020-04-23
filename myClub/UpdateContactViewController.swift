//
//  UpdateContactViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/21.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class UpdateContactViewController: UIViewController {

    @IBOutlet weak var phoneInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    
    var newPhoneString = ""
    var newPhone = 0
    var newEmail = ""
    
    @IBAction func updateButton(_ sender: Any) {
        if validatePhoneInput(phone: phoneInput.text!){
            newPhoneString = phoneInput.text!
        }else{
            let prompt = UIAlertController(title: "Wrong phone format!", message: "Check your phone number. It should be an 11-digit phone number.", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
            }))
            self.present(prompt,animated: true)
        }
        if validateEmailInput(email: emailInput.text!){
            newEmail = emailInput.text!
        }else{
            let prompt = UIAlertController(title: "Wrong Email format!", message: "Check your Email", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
            }))
            self.present(prompt,animated: true)
        }
        
        
        editProfile(id: user!.id!, name: user!.name!, gender: user!.gender!, type: user!.type!, nationality: user!.nationality!, email: newEmail, phone: newPhoneString, completionHandler: {(success) in
            guard success == true else{
                //Update failed
                let prompt = UIAlertController(title: "Update failed", message: "Your contact information can not be updated", preferredStyle: .alert)
                prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                    action in
                    self.viewDidLoad()
                }))
                self.present(prompt,animated: true)
                print("Update failed")
                return
            }
            //Update successfully
            let prompt = UIAlertController(title: "Update successfully", message: "Your contact information has been updated", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
            }))
            self.present(prompt,animated: true)
            print("Update successfully")
            
            return
        })
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeyboard()

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
