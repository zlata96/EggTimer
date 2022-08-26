//
//  ViewController.swift
//  EggTimer
//
//  Created by Злата Гусева on 25.08.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft" : 300, "Medium" : 420, "Hard" : 720]
    var timer = Timer()
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.isHidden = true
        progressBar.isHidden = true
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        let totalTime = eggTimes[hardness]!
        titleLabel.text = hardness

        var secondsPassed = 0
        progressBar.progress = 0
        timeLabel.isHidden = false
        progressBar.isHidden = false
        timeLabel.text = ""
        timer.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { Timer in
            if secondsPassed < totalTime {
                secondsPassed += 1
                self.progressBar.progress = Float(secondsPassed) / Float(totalTime)
                self.timeLabel.text = "\(secondsPassed) of \(totalTime) seconds"
            } else {
                Timer.invalidate()
                self.titleLabel.text = "Done!"
                self.playSound()
            }
        }
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm", ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
