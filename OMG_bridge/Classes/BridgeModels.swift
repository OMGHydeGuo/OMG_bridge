//
//  BridgeModels.swift
//  OMG_Pro
//
//  Created by Hydeguo on 2018/9/21.
//  Copyright © 2018 Hydeguo. All rights reserved.
//

import Foundation


public struct BridgeResponse : Codable {
    
    public var status:Int
    public var body:BridgeBody
}


public struct BridgeBody : Codable {
    
    public var _id:String
    public var updatedAt:String
    public var createdAt:String
    public var originName:String
    public var fileName:String
    public var tenant_id:String
    public var thumbnail:String
    public var logo:String
    public var fingerPrints:[FingerPrintsBody]
    public var type:String
}

public struct FingerPrintsBody : Codable {
    
    public var _id:String
    public var updatedAt:String
    public var createdAt:String
    public var title:String
    public var description:String
    public var linkURL:String
    public var callbackURL:String
    public var fingerPrintReady:Bool
}


