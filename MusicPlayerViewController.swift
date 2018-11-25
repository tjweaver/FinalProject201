//
//  MusicPlayerViewController.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 11/22/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class MusicPlayerViewController: UIViewController {

    let forwardButton = UIButton(frame: CGRect(x: 0, y: 480, width: 40, height: 40))
    let backwardButton = UIButton(frame: CGRect(x: 0, y: 480, width: 40, height: 40))
    let playerButton = UIButton(frame: CGRect(x: 30, y: 470, width: 60, height: 60))
    let volumeSlider = UISlider(frame: CGRect(x: 0, y: 540, width: 300, height: 60))
    let artistTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    let songTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    var player: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        self.volumeSlider.value = (self.volumeSlider.maximumValue / 2);
        let volumeView = MPVolumeView(frame: CGRect(x: 0, y: 560, width: 300, height: 60))
        volumeView.center.x = view.center.x
        volumeView.backgroundColor = UIColor.clear
        self.view.addSubview(volumeView)*/
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        let darkPurple = UIColor(red: 24/255.0, green: 18/255.0, blue: 97/255.0, alpha: 1.0)
        let gradient = CAGradientLayer()
        gradient.colors = [black.cgColor, darkPurple.cgColor]
        gradient.locations = [0.0, 0.75, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = view.frame
        self.view.layer.insertSublayer(gradient, at: 0)
        
        artistTitle.center.x = self.view.center.x
        artistTitle.center.y = 120
        artistTitle.textAlignment = .center
        artistTitle.text = "Artist"
        artistTitle.textColor = UIColor.white
        let sfont = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
        artistTitle.font = sfont
        self.view.addSubview(artistTitle)
        
        songTitle.center.x = self.view.center.x
        songTitle.center.y = 290
        songTitle.textAlignment = .center
        songTitle.text = "Song"
        songTitle.textColor = UIColor.white
        songTitle.font = sfont
        self.view.addSubview(songTitle)
        
        
        let playerImage = UIImage(named: "music-play-button")
        playerButton.setImage(playerImage , for: .normal)
        //playerButton.setTitle("Play Button", for: .normal)
        playerButton.addTarget(self, action: #selector(pausePlayAction), for: .touchUpInside)
        self.view.addSubview(playerButton)
        playerButton.center.x = view.center.x
        
        let forwardImage = UIImage(named: "forward")
        forwardButton.setImage(forwardImage , for: .normal)
        //playerButton.setTitle("Play Button", for: .normal)
        forwardButton.addTarget(self, action: #selector(forwardAction), for: .touchUpInside)
        self.view.addSubview(forwardButton)
        forwardButton.center.x = view.center.x+85
        
        let backwardImage = UIImage(named: "backward")
        backwardButton.setImage(backwardImage , for: .normal)
        //playerButton.setTitle("Play Button", for: .normal)
        backwardButton.addTarget(self, action: #selector(backwardAction), for: .touchUpInside)
        self.view.addSubview(backwardButton)
        backwardButton.center.x = view.center.x-90
        
        volumeSlider.center.x = view.center.x
        volumeSlider.addTarget(self, action: #selector(sliderValueChanged), for: .allTouchEvents)
        self.view.addSubview(volumeSlider)

        let defaultAlbum = "defaultAlbum.png"
        let albumImage = UIImage(named: defaultAlbum)
        let albumView = UIImageView(image: albumImage!)
        albumView.frame = CGRect(x: 0, y: 150, width: 120, height: 120)
        view.addSubview(albumView)
        albumView.center.x = view.center.x
        
        do
        {
            let audioPath = Bundle.main.path(forResource: "take-me-home", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch
        {
            
        }
    }
    
    
    @objc func pausePlayAction(sender: UIButton!) {
        
        Main().setIsPlaying(play: !Main().gettIsPlaying())
        
        if(Main().gettIsPlaying() == true)
        {
            player.play()
            print("pause")
            let updateImage = UIImage(named: "pause-button")
            playerButton.setImage(updateImage, for: .normal)
        }
        else
        {
            player.pause()
            print("play")
            let updateImage = UIImage(named: "music-play-button")
            playerButton.setImage(updateImage, for: .normal)
        }
    }
    
    @objc func sliderValueChanged(sender: UISlider) {
        
        let selectedValue = Float(sender.value)
        print(selectedValue)
        player.volume = selectedValue
        
    }
    

    @objc func forwardAction(sender: UIButton!) {
        
        print("forward")
    }
    
    @objc func backwardAction(sender: UIButton!) {
        
        print("backward")
    }
    
    func trackAudio() {
//        var normalizedTime = Float(player.currentTime * 100.0 / player.duration)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
