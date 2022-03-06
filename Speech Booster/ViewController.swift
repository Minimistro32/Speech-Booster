//
//  ViewController.swift
//  Speech Booster
//
//  Created by Tyson_Freeze on 12/24/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    var session: AVAudioSession {
        AVAudioSession.sharedInstance()
    }
    
    let engine: AVAudioEngine = AVAudioEngine()
    var file: AVAudioFile?
    var isRecording: Bool = false
    var recordingExists: Bool = false
    var player = AVAudioPlayerNode()
    var eqEffect = AVAudioUnitEQ()
    
    //execution starts here
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            //set session variables to prevent inteference with currently playing audio
            try session.setCategory(.playAndRecord, options: .mixWithOthers)
            try session.setActive(true)
        } catch {
            print(error)
        }
    }
    
    //These two functions configure the audio engine for different functions.
    func configureRecording() {
        try! file = AVAudioFile(forWriting: URLFor("my_file.caf")!, settings: engine.mainMixerNode.inputFormat(forBus: 0).settings)
        engine.connect(engine.inputNode, to: engine.mainMixerNode, format: engine.inputNode.outputFormat(forBus: 0))
    }
    
    func configurePlaying() {
        engine.attach(player)
        eqEffect.globalGain = 50
        engine.attach(eqEffect)
        engine.connect(player, to: eqEffect, format: file?.processingFormat)
        engine.connect(eqEffect, to: engine.outputNode, format: file?.processingFormat)
    }
    
    //This function will stop (if needed), configure, and start the audio engine
    func startEngine(recording: Bool? = nil) {
        if self.engine.isRunning {
            self.engine.stop()
        }
        engine.reset()
        
        if recording ?? false {
            configureRecording()
        } else {
            configurePlaying()
        }
        
        do {
            engine.prepare()
            try engine.start()
        } catch {
            print(error)
        }
    }
    
    //This is if the button is pressed
    @IBAction func boostPressed(_ sender: Any) {
        if recordingExists {
            if let file = file {
                startEngine()
                print("play recording")
                player.play()
                player.scheduleFile(file, at: nil) {
                    self.recordingExists = false
                }
                button.setTitle("Record", for: .normal)
            }
        } else {
            if isRecording {
                print("remove tap")
                engine.mainMixerNode.removeTap(onBus: 0)
                recordingExists = true
                button.setTitle("Play", for: .normal)
            } else {
                startEngine(recording: true)
                print("install tap")
                engine.mainMixerNode.installTap(onBus: 0, bufferSize: 1024, format: engine.mainMixerNode.outputFormat(forBus: 0)) { (buffer, time) -> Void in
                    try! self.file?.write(from: buffer)
                    return
                }
                button.setTitle("Stop", for: .normal)
            }
            isRecording.toggle()
        }
    }
    
    
    //This wrapper generates a URL from the FileManager
    func URLFor(_ filename: String) -> URL? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(filename)
    }

}

