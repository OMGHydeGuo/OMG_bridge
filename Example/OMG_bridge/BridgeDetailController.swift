//
//  BridgeDetailController.swift
//  OMG_Pro
//
//  Created by Hydeguo on 2018/7/31.
//  Copyright © 2018 Hydeguo. All rights reserved.
//




import Foundation
import UIKit
import Alamofire
import OMG_bridge

class BridgeDetailController: UITableViewController{
    
    
    
    static var data:BridgeBody?
    
    let identifier: String = "BridgeDetailCell"
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let iconTop = UIImageView(image: UIImage(named: "homeicon"))
        //        iconTop.scale = 0.5
        iconTop.contentMode = .scaleAspectFit
        navigationItem.titleView = iconTop
        navigationItem.title = ""
        
        
        self.tableView.separatorInset = UIEdgeInsets.zero;
        self.tableView.layoutMargins = UIEdgeInsets.zero;
        self.tableView.separatorColor = UIColor.darkGray
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    
    
    // MARK: UITableView DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BridgeDetailCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! BridgeDetailCell
        if let data = BridgeDetailController.data
        {
            cell.configurateTheCell(data)
            cell.detailFunc = onClickDetail
        }
        cell.layoutMargins = UIEdgeInsets.zero;
        //        cell.selectionStyle = .none;
        return cell
        
    }
    
    func onClickDetail()
    {
        guard BridgeDetailController.data != nil else {
            return
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
   
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return .none
    }
    
    
}
