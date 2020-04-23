//
//  AddStaffViewController.swift
//  myClub
//
//  Created by 徐晗超 on 2020/4/21.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MAddStaffViewController: UIViewController {
    var selectedTeamStaff:staff = staff(nationality: "", name: "", gender: "", id: 0, type: "", email: "", phone: "")
    
    
    @IBOutlet var name: UITextField!
    
    @IBOutlet var gender: UITextField!
    
    @IBOutlet var nationality: UITextField!
    @IBOutlet var type: UITextField!
    
    @IBOutlet var phone: UITextField!
    
    
    @IBOutlet var email: UITextField!
    
    
    @IBAction func addButton(_ sender: Any) {
         if name.text!.isEmpty||gender.text!.isEmpty||nationality.text!.isEmpty||type.text!.isEmpty||phone.text!.isEmpty||phone.text!.isEmpty{
                   let prompt = UIAlertController(title: "Input Failed", message: "There is empty input,please try again", preferredStyle: .alert)
                   prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                       action in
                       self.viewDidLoad()
                       
                   }))
                   self.present(prompt,animated: true)
                   print("input fail")
                   
               }
               else if validateEmailInput(email: email.text!)||validatePhoneInput(phone: phone.text!){
                   
                   
                   insertStaff(name: name.text!, gender: gender.text!, type: type.text!, nationality: nationality.text!, email: email.text!, phone: phone.text!, completionHandler: {(success) in
                       
                       guard success == true else{
                           
                           let prompt = UIAlertController(title: "Add Failed", message: "Your add failed. Please check and add again", preferredStyle: .alert)
                           prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                               action in
                               self.viewDidLoad()
                               
                           }))
                           self.present(prompt,animated: true)
                           print("Add fail")
                           return
                       }
                       
                       let prompt = UIAlertController(title: "Add succeed", message: "You have already added a new team player ", preferredStyle: .alert)
                       prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                           action in
                           self.performSegue(withIdentifier: "toStaff", sender: self)
                           self.viewDidLoad()
                       }))
                       self.present(prompt,animated: true)
                       print("add success")
                       
                   })
               }else{
                   
                   let prompt = UIAlertController(title: "Wrong Input", message: "Check your phone number and email. Phone number should be an 11-digit phone number. ", preferredStyle: .alert)
                   prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                       action in
                       
                       self.viewDidLoad()
                   }))
                   self.present(prompt,animated: true)
                   print("wrong input")
                   
    }
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
