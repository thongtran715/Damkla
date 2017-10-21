//
//  ListenViewController.swift
//  Damkla
//
//  Created by Thong Tran on 9/6/17.
//  Copyright © 2017 ThongApp. All rights reserved.
//

import UIKit
import ReadabilityKit
import algorithmia
import AVFoundation
class ListenViewController: UIViewController {
     let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    var playBtn = UIBarButtonItem()
    var pauseBtn = UIBarButtonItem()
    var isSummary = false
    var new: News!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playBtn = UIBarButtonItem(barButtonSystemItem: .play , target: self, action: #selector(playBtnAction(sender:)))
        self.pauseBtn = UIBarButtonItem(barButtonSystemItem: .pause , target: self, action: #selector(pauseBtnAction(sender:)))
        self.navigationItem.rightBarButtonItem = playBtn
    }
    override func viewWillAppear(_ animated: Bool) {
        let url = URL(string: new.contextURL)
        var textOut = ""
        Readability.parse(url: url!) { (data) in
            let text = data?.text?.components(separatedBy: "Risk Briefing                                                                                                                      \n            ")
            textOut = (text?[1])!
            if self.isSummary == false {
                self.textView.text = textOut
            }
            else
            {
                let input = textOut
                let client = Algorithmia.client(simpleKey: "sim4t+I0YqoqesIbWuP6QkGw2uC1")
                let summarizer = client.algo(algoUri: "nlp/Summarizer/0.1.3")
                      summarizer.pipe(text: input) { resp, error in
                        DispatchQueue.main.async {
                        print(resp.getText())
                        self.textView.text = resp.getText()
                        }
                }
              
            }
        }
    }
    @IBOutlet var textView: UITextView!


    func playBtnAction(sender: UIBarButtonItem)
    {
            self.myUtterance = AVSpeechUtterance(string: textView.text)
                            self.myUtterance.rate = 0.5
                            self.synth.speak(self.myUtterance)
        self.navigationItem.rightBarButtonItem = pauseBtn
    }
    
    func pauseBtnAction(sender: UIBarButtonItem)
    {
        self.synth.pauseSpeaking(at: .immediate)
        self.navigationItem.rightBarButtonItem = playBtn
    }
}
