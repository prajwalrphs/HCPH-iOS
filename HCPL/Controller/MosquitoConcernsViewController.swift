//
//  MosquitoConcernsViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 23/12/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit

class MosquitoConcernsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var arrofname = [" Dead Birds"," Mosquito Breeding"," Disease Activity"," Apray Area"," Visit Our Website"," Report Issues"]
    
    var imagearray = [#imageLiteral(resourceName: "mosq1"),#imageLiteral(resourceName: "mosq2"),#imageLiteral(resourceName: "mosq3"),#imageLiteral(resourceName: "mosq4"),#imageLiteral(resourceName: "pic6"),#imageLiteral(resourceName: "pic7")]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagearray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MosquitoConcernsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MosquitoConcernsTableViewCell", for: indexPath) as! MosquitoConcernsTableViewCell
        
        cell.img.image = imagearray[indexPath.row]
        cell.lbl.text = arrofname[indexPath.row]
        
        cell.mainview.layer.cornerRadius = 20
        cell.mainview.clipsToBounds = true
        
        return cell
    }

}
