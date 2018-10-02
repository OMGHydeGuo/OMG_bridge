//
//  ViewController.swift
//  OMG_bridge
//
//  Created by Hyde Guo on 10/02/2018.
//  Copyright (c) 2018 Hyde Guo. All rights reserved.
//

import UIKit
import OMG_bridge

class ViewController: BaseBridgeViewController ,BridgeDelegate{
    func onListening() {
        
    }
    
    func onGetBridgeData(data: BridgeBody?) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var _ = ListeningController()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

