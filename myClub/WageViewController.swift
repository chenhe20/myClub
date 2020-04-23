//
//  WageViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/17.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class WageViewController: UIViewController {
    
    @IBOutlet weak var contractIdDetail: UILabel!
    @IBOutlet weak var startTimeDetail: UILabel!
    @IBOutlet weak var endTimeDetail: UILabel!
    @IBOutlet weak var basicWageDetail: UILabel!
    @IBOutlet weak var bonusorpenalty: UILabel!
    @IBOutlet weak var yearInput: UITextField!
    @IBOutlet weak var monthInput: UITextField!
    @IBOutlet weak var wage: UILabel!
    @IBOutlet weak var bonus: UILabel!
    @IBOutlet weak var totalWage: UILabel!
    
    var staffContract:[contract] = []
    var staffMonthlyWage:monthlyWage = monthlyWage(total: 0.0, bonus: 0.0, basicWage: 0.0, leaveTime: 0, absentTime: 0, presentTime: 0, staffName: "", staffId: 0)
    var month = ""
    var year = ""
    var validatedMonth = ""
    
    @IBAction func searchWage(_ sender: Any) {
        if validateMonth(monthInput: monthInput.text!)&&validateYear(yearInput: yearInput.text!){
            month = monthInput.text!
            year = yearInput.text!
            validatedMonth = year+"/"+month
        }else{
            let prompt = UIAlertController(title: "Wrong input!", message: "Check your Month/Year input", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
            }))
            self.present(prompt,animated: true)
        }
        searchMonthlyWage(staffId: user!.id!, month: validatedMonth, completionHandler: {(monthlyWage) in
            self.staffMonthlyWage = monthlyWage
            if let bw = self.staffMonthlyWage.basicWage{
                self.wage.text = String(bw)
            }else{
                self.wage.text = ""
            }
            if let bp = self.staffMonthlyWage.bonus{
                self.bonusorpenalty.text = String(bp)
            }else{
                self.bonusorpenalty.text = ""
            }
            if let tw = self.staffMonthlyWage.total{
                self.totalWage.text = String(tw)
            }else{
                self.totalWage.text = ""
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeyboard()
        searchContractById(staffID: user?.id ?? 1, completionHandler: {(contract) in
            self.staffContract = contract
            let currentContract = self.staffContract.count-1
            if let id =  self.staffContract[currentContract].contractId{
               self.contractIdDetail.text = String(id)
            }
            else{
               self.contractIdDetail.text = "";
            }
            self.startTimeDetail.text = self.staffContract[currentContract].startDate
            self.endTimeDetail.text = self.staffContract[currentContract].endDate
            if let basicWage = self.staffContract[currentContract].basicWage{
                self.basicWageDetail.text = String(basicWage)
            }else{
                self.basicWageDetail.text = ""
            }
            if let bonus =  self.staffContract[currentContract].bonus{
               self.bonus.text = String(bonus)
            }else{
               self.bonus.text = "";
            }
            
        })
        
        
        
        getCurMonthWage(staffId: user?.id ?? 1, completionHandler: {(monthlyWage) in
            self.staffMonthlyWage = monthlyWage
            if let bw = self.staffMonthlyWage.basicWage{
                self.wage.text = String(bw)
            }else{
                self.wage.text = ""
            }
            if let bp = self.staffMonthlyWage.bonus{
                self.bonusorpenalty.text = String(bp)
            }else{
                self.bonusorpenalty.text = ""
            }
            if let tw = self.staffMonthlyWage.total{
                self.totalWage.text = String(tw)
            }else{
                self.totalWage.text = ""
            }
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
