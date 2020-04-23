//
//  ContractDetailViewController.swift
//  myClub
//
//  Created by 徐晗超 on 2020/4/21.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MContractDetailViewController: UIViewController {
    var selectedContract:contract = contract(contractId: 0, startDate: "", endDate: "", basicWage: 0.0, bonus: 0.0, staffName: "", staffId: 0)
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var staffid: UILabel!
    @IBOutlet weak var contractid: UILabel!
    @IBOutlet weak var startdate: UILabel!
    @IBOutlet weak var enddate: UILabel!
    @IBOutlet weak var basicwage: UILabel!
    @IBOutlet weak var bonus: UILabel!
    
    @IBAction func deleteButton(_ sender: Any) {
        deleteContract(contractID: selectedContract.contractId!, completionHandler: {(success) in
            guard success == true else{
                let prompt = UIAlertController(title: "Delete Failed", message: "Your delete failed. Please delete again", preferredStyle: .alert)
                prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                    action in
                    self.viewDidLoad()
                    
                }))
                self.present(prompt,animated: true)
                print("Delete fail")
                return
            }
            let prompt = UIAlertController(title: "Delete Succeed", message: "Your delete succeed.", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
                
            }))
            self.present(prompt,animated: true)
            print("Delete succeed")
            
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddContract"{
            let secondViewController = segue.destination as! MAddContractViewController
            
            secondViewController.selectedContract = self.selectedContract
        }
        if segue.identifier == "toChangeContractDetail"{
            let secondViewController = segue.destination as! MChangeContractViewController
            
            secondViewController.selectedContract = self.selectedContract
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = selectedContract.staffName
        staffid.text = String(selectedContract.staffId!)
        contractid.text = String(selectedContract.contractId!)
        
        
        startdate.text = timeFormatter(date:  selectedContract.startDate!)
        
        enddate.text = timeFormatter(date:  selectedContract.endDate!)
        
        basicwage.text = String(selectedContract.basicWage!)
        bonus.text = String(selectedContract.bonus!)
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
