//
//  EditAccountViewController.swift
//  myClub
//
//  Created by 徐晗超 on 2020/4/22.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MEditAccountViewController: UIViewController {
    
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var gender: UITextField!
    
    
    @IBOutlet weak var nationality: UITextField!
    
    
    @IBOutlet weak var type: UITextField!
    
    
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    
    var newPhoneString = ""
    var newPhone = 0
    var newEmail = ""
    
    @IBAction func saveButton(_ sender: Any) {
        
        if validatePhoneInput(phone: phone.text!){
            newPhoneString = phone.text!
        }else{
            let prompt = UIAlertController(title: "Wrong phone format!", message: "Check your phone number. It should be an 11-digit phone number.", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
            }))
            self.present(prompt,animated: true)
        }
        
        if validateEmailInput(email: email.text!){
            newEmail = email.text!
        }else{
            let prompt = UIAlertController(title: "Wrong Email format!", message: "Check your Email", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
            }))
            self.present(prompt,animated: true)
        }
        
        
        
        modifyStaff(id: (user?.id!)!, name: (user?.name)!, gender: gender.text!, type: type.text!, nationality: nationality.text!, email: email.text!, phone: phone.text!, completionHandler: {(success) in
            
            guard success == true else{
                let prompt = UIAlertController(title: "Update failed", message: "Your  update failed", preferredStyle: .alert)
                prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                    action in
                    self.viewDidLoad()
                }))
                self.present(prompt,animated: true)
                print("update fail")
                return
            }
            let prompt = UIAlertController(title: "Update Succeed", message: "Your  update succeed", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
            }))
            self.present(prompt,animated: true)
            print("update success")
            
            
            
            
            
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeyboard()
        if let staffId = user?.id {
            id.text = String(staffId )
        }
        
        
        
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
