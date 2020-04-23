//
//  WageViewController.swift
//  myClub
//
//  Created by Wenzhe Zhang on 2020/4/17.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MWageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var transactionTable: UITableView!

    var transactions:[transaction] = []
    var selectedTransaction:transaction = transaction(transactionId: 0,name: "", date: "", amount: 0.0, description:"")
    
    var currentCell = -1

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "transactionCell")
            cell.accessoryType = .disclosureIndicator
        cell.textLabel!.text = transactions[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCell = indexPath.row
        selectedTransaction = transactions[currentCell]
        performSegue(withIdentifier: "toDetailTransaction", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "toDetailTransaction"{
                    let secondViewController = segue.destination as! MTransactionDetailInfoViewController
//                    secondViewController.selectedTransaction = self.selectedTransaction
               secondViewController.selectedTransaction = self.selectedTransaction
                }
    }
    
    @IBAction func unwindtoFinance(_ sender: UIStoryboardSegue) {
       viewDidLoad()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        transactionTable.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllTransactions(completionHandler: {(transactions) in
            self.transactions = transactions
            self.transactionTable.reloadData()
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
