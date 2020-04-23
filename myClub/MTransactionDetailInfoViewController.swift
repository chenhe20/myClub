//
//  TransactionDetailInfoViewController.swift
//  myClub
//
//  Created by 徐晗超 on 2020/4/21.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MTransactionDetailInfoViewController: UIViewController {
    var selectedTransaction:transaction = transaction(transactionId: 0,name: "", date: "", amount: 0.0, description:"")
    
    @IBOutlet weak var id: UILabel!
    
    
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    
    @IBAction func deleteButton(_ sender: Any) {
        deleteTransaction(transactionID: selectedTransaction.transactionId!, completionHandler: {(success) in
            
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
            
            let prompt = UIAlertController(title: "Delete Succeed", message: "You have already deleted this transaction", preferredStyle: .alert)
            prompt.addAction(UIAlertAction(title:"Back",style: .default,handler: {
                action in
                self.viewDidLoad()
            }))
            self.present(prompt,animated: true)
            print("delete success")
            
        })
    }
    
    
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        self.HideKeyboard()
        if let transid = selectedTransaction.transactionId{
            id.text = String(transid)
        }
        name.text = selectedTransaction.name
        date.text = selectedTransaction.date
        if let transamount = selectedTransaction.amount{
            amount.text = String(transamount)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == " toChangeTransactionDetail"{
            let secondViewController = segue.destination as! MChangeTransactionDetailViewController
            
            secondViewController.selectedTransaction = self.selectedTransaction
        }
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
