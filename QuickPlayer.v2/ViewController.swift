//
//  ViewController.swift
//  QuickPlayer.v2
//
//  Created by Tung on 6/22/17.
//  Copyright © 2017 Tung. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate {
    var audio = AVAudioPlayer()
    var status = 1
    @IBOutlet weak var btn_play: UIButton!
    @IBOutlet weak var sld_Volume: UISlider!
    @IBOutlet weak var lbl_timeCurrent: UILabel!
    @IBOutlet weak var lbl_timeRight: UILabel!
    @IBOutlet weak var sld_duration: UISlider!
    @IBOutlet weak var sw_repeat: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType:".mp3")!) as URL)
        addThumbImgForSlider()
        checkRepeat()
        audio.delegate = self
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeCurrent), userInfo: nil, repeats: true)

    
    }
    func updateTimeCurrent()
    {
        let currentTime = Int(audio.currentTime)
        let minTimeCurrent = currentTime/60
        let secTimeCurrent = currentTime - minTimeCurrent*60
        self.lbl_timeCurrent.text = String(format: "%02d:%02d", minTimeCurrent, secTimeCurrent)
        let durationTime = Int(audio.duration)
        let timeRight = durationTime - currentTime
        let minTimeRight = timeRight/60
        let secTimeRight = timeRight - minTimeRight*60
        self.lbl_timeRight.text = String(format: "%02d:%02d", minTimeRight, secTimeRight)
        self.sld_duration.value = Float(audio.currentTime/audio.duration)
        if audio.currentTime == 0
        {
            changePlay()
        }

    }
    func addThumbImgForSlider(){
        sld_Volume.setThumbImage(UIImage(named: "thumb.png"), for: .normal)
        sld_Volume.setThumbImage(UIImage(named: "thumbHightLight.png"), for: .highlighted)
    }
    func playPause(){
        if status == 1{
            btn_play.setImage(UIImage(named: "pause.png"), for: .normal)
            audio.play()
            status = 2
        }else{
            btn_play.setImage(UIImage(named: "play.png"), for: .normal)
            audio.pause()
            status = 1
        }
    }
    func changePlay(){
        print (String(audio.currentTime))
        print(String(audio.duration))
        if sw_repeat.isOn == false {
            btn_play.setImage(UIImage(named: "play.png"), for: .normal)
        }
    }
    func checkRepeat(){
        if sw_repeat.isOn == true {
            audio.numberOfLoops = -1
        }else{
            audio.numberOfLoops = 0
        }
    }
    
    @IBAction func sw_Repeat(_ sender: UISwitch) {
        checkRepeat()
    }
    @IBAction func sld_duration(_ sender: UISlider) {
        audio.currentTime = TimeInterval(Float(sender.value) * Float(audio.duration))

    }
    @IBAction func action_play(_ sender: UIButton) {
        playPause()
    }
    @IBAction func sld_Volume(_ sender: UISlider) {
        audio.volume = sender.value
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    }
    
}
