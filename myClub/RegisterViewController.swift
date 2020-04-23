//
//  RegisterViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/21.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var idInput: UITextField!
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var confirmPasswordInput: UITextField!
    
    var idNum = ""
    var idNumber = 0
    var userName = ""
    var password = ""
    var conPassword = ""
    var passwordFinal = ""
    
    @IBAction func Register(_ sender: Any) {
        if validateIDInput(staffID: idInput.text!){
            idNum = idInput.text!
        }else{
            let prompt = UIAlertController(title: "Wrong input!", message: "Check your id", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
            }))
            self.present(prompt,animated: true)
        }
        if validateUsernameInput(username: userNameInput.text!){
            userName = userNameInput.text!
        }else{
            let prompt = UIAlertController(title: "Wrong input!", message: "Check your username", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
            }))
            self.present(prompt,animated: true)
        }
        if validatePasswordInput(password: passwordInput.text!)&&validatePasswordInput(password: confirmPasswordInput.text!){
            password = passwordInput.text!
            conPassword = confirmPasswordInput.text!
            if password == conPassword {
                passwordFinal = passwordInput.text!
            }else{
                let prompt = UIAlertController(title: "Password not Matched", message: "The password and comfirm password do not match", preferredStyle: .alert)
                prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                    action in
                    self.viewDidLoad()
                }))
                self.present(prompt,animated: true)
            }
        }else{
            let prompt = UIAlertController(title: "Wrong input!", message: "The password length should between 1 and 30", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
            }))
            self.present(prompt,animated: true)
        }
        if let id = idInput.text{
          guard let id1 = Int(id) else{return}
            idNumber = id1
        }else{
            idNumber = 0
        }
        
        signUpRequest(username: userName, passwords: passwordFinal, ID: idNumber, completionHandler: {(success) in
            guard success == true else{
                //Register failed
                let prompt = UIAlertController(title: "Register failed", message: "Your id does not exist or username already exists", preferredStyle: .alert)
                prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                    action in
                    self.viewDidLoad()
                }))
                self.present(prompt,animated: true)
                print("Register failed")
                return
            }
            //Register successfully
            let prompt = UIAlertController(title: "Register successfully", message: "You can log in now", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
            }))
            self.present(prompt,animated: true)
            print("Register successfully")
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
