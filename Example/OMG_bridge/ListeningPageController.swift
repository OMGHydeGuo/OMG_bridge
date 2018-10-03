//
//  ListeningPageController.swift
//  OMG_Pro
//
//  Created by Hydeguo on 2018/7/30.
//  Copyright © 2018 Hydeguo. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Alamofire
import OMG_bridge


class ListeningPageController: BaseBridgeViewController,BridgeDelegate{


    @IBOutlet var loading:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.omgBridgeListener.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        loading.isHidden = true
    }
    
    func onListening() {
        
        loading.isHidden = false
    }
    
    func onGetBridgeData(data: BridgeBody?) {
        
        loading.isHidden = true
        if let hasData = data
        {
            BridgeDetailController.data = hasData
            NotificationCenter.default.post(name: Notification.Name(rawValue: "new_bridge"), object: self, userInfo: ["data":hasData])
        }
        self.onReturn()
    }
    
    @IBAction func onReturn()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onStartListener()
    {
        self.omgBridgeListener.startRecord()
    }



}
