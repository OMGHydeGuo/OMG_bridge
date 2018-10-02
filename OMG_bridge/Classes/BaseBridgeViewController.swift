//
//  BaseBridgeViewController.swift
//  OMG_bridge
//
//  Created by Hydeguo on 2018/10/2.
//

import Foundation

import AVFoundation


class BaseBridgeViewController: UIViewController{


    fileprivate var player: AVAudioPlayer?
    
    var omgBridgeListener:ListeningController = ListeningController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         open for shaking detect
         */
        UIApplication.shared.applicationSupportsShakeToEdit = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //-------------------------shark-----------------------
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
  
        /// play sound effect
        let path1 = Bundle.main.path(forResource: "0020", ofType:"aac")
        let data1 = NSData(contentsOfFile: path1!)
        self.player = try? AVAudioPlayer(data: data1! as Data)
//        self.player?.delegate = self
        self.player?.updateMeters()
        self.player?.prepareToPlay()
        self.player?.play()
        
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {

    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        omgBridgeListener.startRecord()
    }
    
    
}
