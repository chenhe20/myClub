//
//  AddContractViewController.swift
//  myClub
//
//  Created by 徐晗超 on 2020/4/21.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MAddContractViewController: UIViewController {
    var selectedContract:contract = contract(contractId: 0, startDate: "", endDate: "", basicWage: 0.0, bonus: 0.0, staffName: "", staffId: 0)
    
    var starty = ""
    var startm = ""
    var startd = ""
    var endy = ""
    var endm = ""
    var endd = ""
    var validatedstart = ""
    var validatedend = ""
    

    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var startyear: UITextField!
    @IBOutlet weak var startmonth: UITextField!
    @IBOutlet weak var startdate: UITextField!
    @IBOutlet weak var basicwage: UITextField!
    @IBOutlet weak var endyear: UITextField!
    @IBOutlet weak var endmonth: UITextField!
    @IBOutlet weak var enddate: UITextField!
    @IBOutlet weak var bonus: UITextField!
    
    @IBAction func addButton(_ sender: Any) {
        if startyear.text!.isEmpty||startmonth.text!.isEmpty||startdate.text!.isEmpty||basicwage.text!.isEmpty||endyear.text!.isEmpty||endmonth.text!.isEmpty||enddate.text!.isEmpty||bonus.text!.isEmpty{
            let prompt = UIAlertController(title: "Input Failed", message: "There is empty input,please try again", preferredStyle: .alert)
                                  prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                                      action in
                                      self.viewDidLoad()
                                      
                                  }))
                                  self.present(prompt,animated: true)
                                  print("input fail")
        }
        if validateMonth(monthInput: startmonth.text!)&&validateYear(yearInput: startyear.text!)&&validateDate(dateInput: startdate!.text!)&&validateMonth(monthInput: endmonth.text!)&&validateYear(yearInput: endyear.text!)&&validateDate(dateInput: enddate.text!){
            starty = startyear.text!
            startd = startdate.text!
            startm = startmonth.text!
            endy = endyear.text!
            endm = endmonth.text!
            endd = enddate.text!
            validatedstart = starty+"/"+startm+"/"+startd
            validatedend = endy+"/"+endm+"/"+endd
            
            insertContract(staffID: selectedContract.staffId!, startDate: validatedstart, endDate: validatedend, basicWage: Double(basicwage.text!)!, bonus:Double(bonus.text!)!, completionHandler: {(success) in
                print("success")
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
                let prompt = UIAlertController(title: "Add Succeed", message: "You have already added a new contract", preferredStyle: .alert)
                prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                    action in
                    self.viewDidLoad()
                }))
                self.present(prompt,animated: true)
                print("Adds succeed")
            })
        }else{
            let prompt = UIAlertController(title: "Wrong input!", message: "Check your Month/Year/Date/Time input", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
            }))
            self.present(prompt,animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeyboard()
        id.text = String(selectedContract.staffId!)
        name.text = String(selectedContract.staffName!)
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
