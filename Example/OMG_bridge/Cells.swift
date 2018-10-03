//
//  Cells.swift
//  OMG_bridge_Example
//
//  Created by Hydeguo on 2018/10/3.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import OMG_bridge


class BridgeCell :UITableViewCell
{
    
    @IBOutlet var viewsL:UIView?
    @IBOutlet var viewsR:UIView?
    @IBOutlet var nameLable:UILabel?
    @IBOutlet var viewsNum:UILabel?
    @IBOutlet var videoImage:UIImageView?
    
    
    func configurateTheCell(_ vo:BridgeBody) {
        
        self.nameLable?.text = vo.fingerPrints[0].title
        self.viewsNum?.text = "0"
        self.videoImage?.image = UIImage()
        
        self.videoImage?.image(fromUrl: vo.thumbnail)
    }
}

class BridgeDetailCell :UITableViewCell
{
    
    @IBOutlet var nameLable:UILabel?
    @IBOutlet var detailLable:UILabel?
    @IBOutlet var bigImage:UIImageView?
    @IBOutlet var iconImage:UIImageView?
    
    var detailFunc:(()->Void)?
    
    func configurateTheCell(_ vo:BridgeBody) {
        
        
        self.nameLable?.text = vo.fingerPrints[0].title
        self.detailLable?.text = vo.fingerPrints[0].description
        self.iconImage?.image(fromUrl: vo.logo)
        self.bigImage?.image(fromUrl: vo.thumbnail)
    }
    
    @IBAction func clickDetail()
    {
        detailFunc?()
    }
}


extension UIImageView {
    public func image(fromUrl urlString: String) {
        guard let url = URL(string: urlString) else {
            print("[warning]:Couldn't create URL from \(urlString)")
            return
        }
        let theTask = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if(response == nil){return}
            
            let status = (response as! HTTPURLResponse).statusCode
            if status == 200{
                if let response = data {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: response)
                    }
                }
            }
        }
        theTask.resume()
    }
}
