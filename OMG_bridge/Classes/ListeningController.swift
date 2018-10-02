//
//  ListeningController.swift
//  OMG_bridge
//
//  Created by Hydeguo on 2018/10/2.
//


import Foundation
import UIKit
import AVFoundation
import Alamofire



public protocol BridgeDelegate: class {
    
    func onListening()
    
    func onGetBridgeData(data:BridgeBody?)
}

class ListeningController: NSObject ,AVAudioRecorderDelegate{
    
    var delegate:BridgeDelegate?
    
    var recording:Bool = false
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    
    override init()
    {
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSession.Category.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() {  allowed in
                DispatchQueue.main.async {
                    if allowed {
                        // self.loadRecordingUI()
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
    }
    
    
    func startRecord()
    {
        guard recording == false else {
            return
        }
        
        delegate?.onListening()
        
        recording = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.endRecord()
        }
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.aac")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
        } catch {
            finishRecording(success: false)
        }
    }
    private func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    private func endRecord()
    {
        recording = false
        finishRecording(success: true)
    }
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            
            let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.aac")
            
            Alamofire.upload(multipartFormData:{ multipartFormData in
                multipartFormData.append(audioFilename, withName: "audio_file")},
                             to:"https://api-bridge.onwardsmg.com/v1/fingerprint/result",
                             method:.post,
                             headers:["Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjQ2ODg2MTE4MDYsImlhdCI6MTUzNTAxMTgwNiwic3ViIjoiNWI3ZTZiZGU5ZWQ2MmYzZGUxMzhlM2U0In0.VNF2__1YPBUmogYtDaGnSdQWYtEtMmfZgRsb4JgHGlE"],
                             encodingCompletion: { encodingResult in
                                switch encodingResult {
                                case .success(let upload, _, _):
                                    upload.responseJSON { response in
                                        debugPrint(response.result)
                                        
                                        let match =  String(data: response.data!, encoding: .utf8)?.contains("Not Match") == false;
                                     
                                        if match
                                        {
                                            do{
                                                let bridgeResponse:[BridgeBody] = try JSONDecoder().decode([BridgeBody].self, from: response.data!)
                                           
                                                let newB = bridgeResponse[0];
                                                self.delegate?.onGetBridgeData(data: newB)
                                                
                                            }catch{
                                                print("[login response error]:\(error.localizedDescription)")
                                            }
//                                            NotificationCenter.default.post(name: Notification.Name(rawValue: "new_bridge"), object: self)
                                        }
                                        
                                    }
                                case .failure(let encodingError):
                                    print(encodingError)
                                    self.delegate?.onGetBridgeData(data: nil)
                                }
            })
            
        } else {
            
        }
    }
    
    private func getDayString(day:Date)->String
    {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss";
        return dateFormatter.string(from: day);
    }
    

}


