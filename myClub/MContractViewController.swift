//
//  ContractViewController.swift
//  myClub
//
//  Created by 徐晗超 on 2020/4/21.
//  Copyright © 2020 Wenzhe Zhang. All rights reserved.
//

import UIKit

class MContractViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var contractTable: UITableView!
    var contracts:[contract] = []
    var selectedContract:contract = contract(contractId: 0, startDate: "", endDate: "", basicWage: 0.0, bonus: 0.0, staffName: "", staffId: 0)
    var currentCell = -1
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contracts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "contractCell")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel!.text = contracts[indexPath.row].staffName
        cell.detailTextLabel!.text = String(contracts[indexPath.row].contractId!)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCell = indexPath.row
        selectedContract = contracts[currentCell]
        performSegue(withIdentifier: "toContractDetail", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toContractDetail"{
                      let secondViewController = segue.destination as! MContractDetailViewController
                      
                      secondViewController.selectedContract = self.selectedContract
    }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        contractTable.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllContracts(completionHandler: {(contracts) in
            self.contracts = contracts
            self.contractTable.reloadData()
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
