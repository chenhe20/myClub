//
//  ChangeTransactionDetailViewController.swift
//  myClub
//
//  Created by 徐晗超 on 2020/4/22.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MChangeTransactionDetailViewController: UIViewController {
    var selectedTransaction:transaction = transaction(transactionId: 0,name: "", date: "", amount: 0.0, description:"")
    var month1 = ""
    var year1 = ""
    var date1 = ""
    var time1 = ""
    var validatedtime = ""
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var date: UITextField!
    
    @IBOutlet weak var amount: UITextField!
    
    @IBOutlet weak var year: UITextField!
    
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var month: UITextField!
    
    @IBAction func saveButton(_ sender: Any) {
        if name.text!.isEmpty||time.text!.isEmpty||date.text!.isEmpty||month.text!.isEmpty||year.text!.isEmpty||amount.text!.isEmpty{
             let prompt = UIAlertController(title: "Input Failed", message: "There is empty input,please try again", preferredStyle: .alert)
                       prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                           action in
                           self.viewDidLoad()
                           
                       }))
                       self.present(prompt,animated: true)
                       print("input fail")
             
         }else if validateMonth(monthInput: month.text!)&&validateYear(yearInput: year.text!)&&validateDate(dateInput: date.text!)&&validateTime(time: time.text!){
            month1 = month.text!
            year1 = year.text!
            date1 = date.text!
            time1 = time.text!
            validatedtime = year1+"/"+month1+"/"+date1+" "+time1
            modifyTransaction(transactionId: selectedTransaction.transactionId!, date: validatedtime, name: name.text!, amount: Double(amount.text!)!, description: selectedTransaction.description!, completionHandler: {(success) in
                guard success == true else{
                    let prompt = UIAlertController(title: "Change Failed", message: "Your change failed. Please try again", preferredStyle: .alert)
                                   prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                                       action in
                                       self.performSegue(withIdentifier: "toFinance", sender: self)
                                       
                                       self.viewDidLoad()
                                   }))
                                   self.present(prompt,animated: true)
                                   print("Change succeed")
                                   return
                }
                let prompt = UIAlertController(title: "Change Succeed", message: "You have already changed this transaction details", preferredStyle: .alert)
                prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                    action in
                    self.performSegue(withIdentifier: "toFinance", sender: self)
                    
                    self.viewDidLoad()
                }))
                self.present(prompt,animated: true)
                print("Change succeed")
            })
        }else{
            let prompt = UIAlertController(title: "Wrong input!", message: "Check your Month/Year/Date/Time input", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.performSegue(withIdentifier: "toFinance", sender: self)
                self.viewDidLoad()
            }))
            self.present(prompt,animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeyboard()
        id.text = String(selectedTransaction.transactionId!)
        
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
