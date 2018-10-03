//
//  BaseBridgeViewController.swift
//  OMG_bridge
//
//  Created by Hydeguo on 2018/10/2.
//

import Foundation

import AVFoundation


open class BaseBridgeViewController: UIViewController{
    
    public let omgBridgeListener:ListeningController = ListeningController()
    
    fileprivate var player: AVAudioPlayer?
    
    override  open func viewDidLoad() {
        super.viewDidLoad()
        /**
         open for shaking detect
         */
        UIApplication.shared.applicationSupportsShakeToEdit = true
    }
    
    override  open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //-------------------------shark-----------------------
    
    override  open func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        /// play sound effect
        let path1 = Bundle.main.path(forResource: "rock", ofType:"mp3")
        let data1 = NSData(contentsOfFile: path1!)
        self.player = try? AVAudioPlayer(data: data1! as Data)
        //        self.player?.delegate = self
        self.player?.updateMeters()
        self.player?.prepareToPlay()
        self.player?.play()
        
    }
    
    override  open func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
    }
    
    override  open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        omgBridgeListener.startRecord()
    }
    
    
}
