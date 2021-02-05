//
//  ReportIssueViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 24/12/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit
import AMTabView

class ReportIssueViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,TabItem {

    var tabImage: UIImage? {
      return UIImage(named: "alarm")
    }
    
    @IBOutlet weak var reporttable: UITableView!
    
    var Arrofname = ["Commercial Pools","Dead Bird","Drinking Water","Food Safety","Mosquito Breading Site","Neighbour hood Nuisance","Animal Report Cruelty"]
    
    var CommercialArray = ["Commercial Pools"]
    var ids = [1]
    var CommercialTitle = "Commercial Pools"
    
    var FoodSafetyArray = ["Food Made Me Sick","Unclean Preparation","Something in My Food"]
    var Foodids = [1,2,3,4]
    var FoodTitle = "Food Safety"
    
    var NeighbourArray = ["Neighbourhood Nuisance"]
    var Neighbourids = [1]
    var NeighbourTitle = "Neighbour hood Nuisance"
    
    var DrinkingWater = ["Public Drinking Water"]
    var DrinkingWaterids = [1]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Arrofname.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:RepostissueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RepostissueTableViewCell", for: indexPath) as! RepostissueTableViewCell
        
        cell.lblname.text = Arrofname[indexPath.row]
        cell.borderview.backgroundColor = UIColor.white
        cell.borderview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.borderview.layer.shadowOpacity = 2
        cell.borderview.layer.shadowOffset = CGSize.zero
        cell.borderview.layer.shadowRadius = 5
        cell.borderview.layer.cornerRadius = 15
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            
            let navigate:CommercialPoolsViewController = self.storyboard?.instantiateViewController(identifier: "CommercialPoolsViewController") as! CommercialPoolsViewController
            navigate.CommercialArray = CommercialArray
            navigate.ids = ids
            navigate.Title = CommercialTitle
            navigate.PlaceholderGet = "Commercial Pools"
            self.navigationController?.pushViewController(navigate, animated: true)
            
        }else if indexPath.row == 1{
            
            let navigate:DeadbirdViewController = self.storyboard?.instantiateViewController(identifier: "DeadbirdViewController") as! DeadbirdViewController
            self.navigationController?.pushViewController(navigate, animated: true)
            
        }else if indexPath.row == 2{
            
            let navigate:CommercialPoolsViewController = self.storyboard?.instantiateViewController(identifier: "CommercialPoolsViewController") as! CommercialPoolsViewController
            navigate.CommercialArray = DrinkingWater
            navigate.ids = DrinkingWaterids
            navigate.PlaceholderGet = "Public Drinking Water"
            navigate.Title = "Drinking Water"
            self.navigationController?.pushViewController(navigate, animated: true)
            
        }else if indexPath.row == 3{
            
            let navigate:CommercialPoolsViewController = self.storyboard?.instantiateViewController(identifier: "CommercialPoolsViewController") as! CommercialPoolsViewController
            navigate.CommercialArray = FoodSafetyArray
            navigate.ids = Foodids
            navigate.Title = FoodTitle
            navigate.PlaceholderGet = "Choose Subject"
            self.navigationController?.pushViewController(navigate, animated: true)
            
        }else if indexPath.row == 4{
            
            let navigate:MosquitoBreedingViewController = self.storyboard?.instantiateViewController(identifier: "MosquitoBreedingViewController") as! MosquitoBreedingViewController
            self.navigationController?.pushViewController(navigate, animated: true)
            
        }else if indexPath.row == 5{
            
            let navigate:CommercialPoolsViewController = self.storyboard?.instantiateViewController(identifier: "CommercialPoolsViewController") as! CommercialPoolsViewController
            navigate.CommercialArray = NeighbourArray
            navigate.ids = Neighbourids
            navigate.Title = NeighbourTitle
            navigate.PlaceholderGet = "Neighbour hood Nuisance"
            self.navigationController?.pushViewController(navigate, animated: true)
            
        }else{
            
            let navigate:ReportanimalViewController = self.storyboard?.instantiateViewController(identifier: "ReportanimalViewController") as! ReportanimalViewController
            self.navigationController?.pushViewController(navigate, animated: true)
            
        }
        
        
    }
    
}
