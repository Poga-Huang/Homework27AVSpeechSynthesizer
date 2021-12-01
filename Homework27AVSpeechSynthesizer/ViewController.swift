//
//  ViewController.swift
//  Homework27AVSpeechSynthesizer
//
//  Created by 黃柏嘉 on 2021/11/30.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    //background
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backView2: UIView!
    
    @IBOutlet weak var utteranceTextView: UITextView!
    @IBOutlet weak var languageSegmented: UISegmentedControl!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    
    @IBOutlet weak var boyImage: UIImageView!
    @IBOutlet weak var girlImage: UIImageView!
    @IBOutlet weak var heartImage: UIImageView!
    
    
    var languageArray = ["zh-TW","en-US"]
    var isPlaying = false
    var synthesis:AVSpeechSynthesizer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //兩個愛心mask
        let heartImage = UIImageView(image: UIImage(named: "heart"))
        let heartImage2 = UIImageView(image: UIImage(named: "heart"))
        heartImage.frame = backView.bounds
        heartImage2.frame = backView2.bounds
        backView.mask = heartImage
        backView2.mask = heartImage2
        
        //初始愛心位置
        updateHeartLocation(degree: 360)
    }
    
    //播放鍵
    @IBAction func play(_ sender: UIButton) {
        if isPlaying == false{
            let selectLanguage = languageArray[languageSegmented.selectedSegmentIndex]
            speak(language: selectLanguage)
            isPlaying = true
        }else{
            synthesis?.continueSpeaking()
            isPlaying = false
        }
    }
    //暫停鍵
    @IBAction func pause(_ sender: UIButton) {
        synthesis?.pauseSpeaking(at: .immediate)
    }
    //說話的function
    func speak(language:String){
        let utterance = AVSpeechUtterance(string: utteranceTextView.text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.volume = volumeSlider.value
        utterance.rate = rateSlider.value
        
        synthesis = AVSpeechSynthesizer()
        synthesis!.speak(utterance)
    }
    //slider滑動改變Label顯示的數值
    @IBAction func changeValue(_ sender: UISlider) {
        if sender.tag == 0{
            volumeLabel.text = String(format: "%.1f", volumeSlider.value)
        }else if sender.tag == 1{
            rateLabel.text = String(format: "%.1f", rateSlider.value)
        }
    }
    
    
    @IBAction func moveCoupleAndHeart(_ sender: UISlider) {
        let distance = sender.value*0.18
        boyImage.frame.origin.x = CGFloat(58+distance)
        girlImage.frame.origin.x = CGFloat(244-distance)
        //移動愛心
        updateHeartLocation(degree: CGFloat(sender.value+360))
    }
    func updateHeartLocation(degree:CGFloat){
        heartImage.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi/180*degree/2).translatedBy(x: 0, y: -180)
    }
    
}

