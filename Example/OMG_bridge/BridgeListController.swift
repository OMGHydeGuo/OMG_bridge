//
//  BridgePageController.swift
//  OMG_Pro
//
//  Created by Hydeguo on 2018/7/30.
//  Copyright © 2018 Hydeguo. All rights reserved.
//



import Foundation
import UIKit
import Alamofire
import OMG_bridge



class BridgeListController: UITableViewController{
    
    var bridge_list = [BridgeBody]()
    
    let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

    let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    
    @IBOutlet var bridgeBtn:UIButton!
    
    let identifier: String = "BridgeCell"
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        self.tableView.separatorInset = UIEdgeInsets.zero;
        self.tableView.layoutMargins = UIEdgeInsets.zero;
        self.tableView.separatorColor = UIColor.darkGray
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.rowHeight = 120 * (view.frame.size.width/375)
        
        self.view.addSubview(bridgeBtn)
        bridgeBtn.frame.origin.y = SCREEN_HEIGHT * 2 / 3
        bridgeBtn.frame.origin.x = SCREEN_WIDTH * 2.7 / 4
        tableView.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onNewBridge), name: NSNotification.Name(rawValue: "new_bridge"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func onNewBridge(_ notice:Notification)
    {
        
        let data:BridgeBody=(notice as NSNotification).userInfo!["data"] as! BridgeBody
        self.bridge_list.append(data)
        self.tableView.reloadData()
        performSegue(withIdentifier: "BridgeDetail", sender: nil)
    }
    
    
    // MARK: UITableView DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BridgeCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! BridgeCell
        cell.configurateTheCell(bridge_list[indexPath.row])
        cell.layoutMargins = UIEdgeInsets.zero;
        //        cell.selectionStyle = .none;
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bridge_list.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            bridge_list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView.isEditing {
            return .delete
        }
        return .none
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        BridgeDetailController.data = bridge_list[indexPath.row]
        

    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    

}
