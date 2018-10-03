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

public class ListeningController: NSObject ,AVAudioRecorderDelegate{
    
    open var delegate:BridgeDelegate?
    
    var recording:Bool = false
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    
    override public init()
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
    
    
    public func startRecord()
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
            AVSampleRateKey: 44100,
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
//                                        debugPrint(response.result)
                                        
                                        let match =  String(data: response.data!, encoding: .utf8)?.contains("Not Match") == false;
                                        
                                        if match
                                        {
                                            do{
                                                let bridgeResponse:[BridgeBody] = try JSONDecoder().decode([BridgeBody].self, from: response.data!)
                                                
                                                let newB = bridgeResponse[0]
                                                self.delegate?.onGetBridgeData(data: newB)
                                                self.sendReport(res_id: newB._id)
                                                
                                            }catch{
                                                print("[JSONDecoder error]:\(error.localizedDescription)")
                                            }
                                        }
                                        else
                                        {
                                            self.delegate?.onGetBridgeData(data: nil)
                                            self.sendReport(res_id: "-1")
                                        }
                                        
                                    }
                                case .failure(let encodingError):
                                    print(encodingError)
                                    self.delegate?.onGetBridgeData(data: nil)
                                    self.sendReport(res_id: "error")
                                }
            })
            
        } else {
            
        }
    }
    
    private func sendReport(res_id:String)
    {
        let json = [
            "device_id":UIDevice.current.identifierForVendor!.uuidString,
            "app_id":Bundle.main.bundleIdentifier!,
            "timestamp": Date().iso8601,
            "result" : res_id
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json,
                                                      options: .prettyPrinted)
            
            let myURL = URL(string: "http://210.5.181.70:5624/bridge/data")!
            let request = NSMutableURLRequest(url: myURL as URL)
            request.httpMethod = "POST"
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
            }
            task.resume()
            
        } catch let error {
            print("error converting to json: \(error)")
            return
        }
    }
    
    private func getDayString(day:Date)->String
    {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss";
        return dateFormatter.string(from: day);
    }
    
    
}



extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}
extension Date {
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}

extension String {
    var dateFromISO8601: Date? {
        return Formatter.iso8601.date(from: self)   // "Mar 22, 2017, 10:22 AM"
    }
}
