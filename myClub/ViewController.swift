//
//  ViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/16.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

//A function to hide the keyboard
extension UIViewController{
    func HideKeyboard(){
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
    }
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var forgotBtn: UIButton!
    @IBOutlet weak var signinBtn: UIButton!
    @IBAction func register(_ sender: Any) {
    }
    @IBAction func forgot(_ sender: Any) {
    }
    @IBAction func signin(_ sender: Any) {

        loginRequest(username: String(username.text!), passwords: String(password.text!), completionHandler: {(success) in
            guard success == true else{
                //Log in failed
                let prompt = UIAlertController(title: "Log in failed", message: "Check your username and password", preferredStyle: .alert)
                prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                    action in
                    self.viewDidLoad()
                }))
                self.present(prompt,animated: true)
                print("Log in failed")
                return
            }
            //Log in successful
            switch user?.type{
            case "Manager": self.performSegue(withIdentifier: "toManagerUI", sender: nil)
            default: self.performSegue(withIdentifier: "toStaffUI", sender: nil)
            }
            if let name = user?.name{
                print("\(name) log in successful")
            }
        })
        
    }
    
    @IBAction func unwindToLogIn(_sender: UIStoryboardSegue){
        UserDefaults.standard.set(false,forKey: "LOGIN_STATE")
        LOGIN_STATE = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initApp()
        self.HideKeyboard()
        
        // Do any additional setup after loading the view.
    }
    
    func initApp(){

        let SAVED_LOGIN_STATE = UserDefaults.standard.object(forKey: "LOGIN_STATE")
        LOGIN_STATE = SAVED_LOGIN_STATE as? Bool ?? false
        
        //if the user has logged before
        if (LOGIN_STATE!){
            user = staff.init(nationality: UserDefaults.standard.string(forKey: "nationality"),
                              name: UserDefaults.standard.string(forKey: "name"),
                              gender: UserDefaults.standard.string(forKey: "gender"),
                              id: UserDefaults.standard.integer(forKey: "id"),
                              type: UserDefaults.standard.string(forKey: "type"),
                              email: UserDefaults.standard.string(forKey: "email"),
                              phone: UserDefaults.standard.string(forKey: "phone"))
            
            switch user?.type{
            case "Manager":
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toManagerUI", sender: nil)
                }
            default:
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toStaffUI", sender: nil)
                }
            }
        }else
        {
//            switch user?.type{
//            case "Manager":
//                DispatchQueue.main.async {
//                    self.performSegue(withIdentifier: "toStaffUI", sender: nil)
//                }
//            default:
//                DispatchQueue.main.async {
//                    self.performSegue(withIdentifier: "toStaffUI", sender: nil)
//                }
//            }
        }
    }

}

