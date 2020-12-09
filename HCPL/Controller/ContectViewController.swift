//
//  ContectViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 26/11/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit
import AMTabView

class ContectViewController: UIViewController,TabItem,UITableViewDelegate,UITableViewDataSource {

    var tabImage: UIImage? {
      return UIImage(named: "call-2")
    }
    
    @IBOutlet weak var Contactstable: UITableView!
    
    var arrTitle = ["For Food establishment (Environmental Public Health)","For Report issue (Home Screen)","For Food establishment (Environmental Public Health)","For Report issue (Home Screen)"]
    var arrAddress = ["101 S.Richey Suite G, Pasadena, TX 77506 \n101 S.Richey Suite G, Pasadena, TX 77506","101 S.Richey Suite G, Pasadena, TX 77506 \n101 S.Richey Suite G, Pasadena, TX 77506","101 S.Richey Suite G, Pasadena, TX 77506 \n101 S.Richey Suite G, Pasadena, TX 77506","101 S.Richey Suite G, Pasadena, TX 77506 \n101 S.Richey Suite G, Pasadena, TX 77506"]
    var arrMap = ["2223 West Loop South, Houston, TX 77027","2223 West Loop South, Houston, TX 77027","2223 West Loop South, Houston, TX 77027","2223 West Loop South, Houston, TX 77027"]
    var arrMObile = ["(713)439-6000","(713)439-6000","(713)439-6000","(713)439-6000"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ContactallTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactallTableViewCell", for: indexPath) as! ContactallTableViewCell
        
        cell.lbltitle.text = arrTitle[indexPath.row]
        cell.lbladdress.text = arrAddress[indexPath.row]
        cell.lblmap.text = arrMap[indexPath.row]
        cell.lblmobilenumber.text = arrMObile[indexPath.row]
        
        cell.contectview.layer.cornerRadius = 10
        
        cell.contectview.backgroundColor = UIColor.white
        cell.contectview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.contectview.layer.shadowOpacity = 2
        cell.contectview.layer.shadowOffset = CGSize.zero
        cell.contectview.layer.shadowRadius = 2
        
        cell.btncall.layer.cornerRadius = 15

        cell.btnlocation.layer.cornerRadius = 15

        
        return cell
        
    }
}
