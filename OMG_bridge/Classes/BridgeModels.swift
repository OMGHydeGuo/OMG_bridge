//
//  BridgeModels.swift
//  OMG_Pro
//
//  Created by Hydeguo on 2018/9/21.
//  Copyright © 2018 Hydeguo. All rights reserved.
//

import Foundation


public struct BridgeResponse : Codable {
    
    var status:Int
    var body:BridgeBody
}


public struct BridgeBody : Codable {
    
    var _id:String
    var updatedAt:String
    var createdAt:String
    var originName:String
    var fileName:String
    var tenant_id:String
    var thumbnail:String
    var logo:String
    var fingerPrints:[FingerPrintsBody]
    var type:String
}

public struct FingerPrintsBody : Codable {
    
    var _id:String
    var updatedAt:String
    var createdAt:String
    var title:String
    var description:String
    var linkURL:String
    var callbackURL:String
    var fingerPrintReady:Bool
}


