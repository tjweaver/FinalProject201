//
//  SecondViewController.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 10/29/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
// SEARCH

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    // chainable animator
    let searchButton = UIButton(frame: CGRect(x: 30, y: 450, width: 100, height: 100))
    let artistNameField =  UITextField(frame: CGRect(x: 30, y: 300, width: 300, height: 40))
    let songNameField =  UITextField(frame: CGRect(x: 30, y: 360, width: 300, height: 40))
    let searchTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.title = "Search"
        // Background visuals
        let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        let darkPurple = UIColor(red: 24/255.0, green: 18/255.0, blue: 97/255.0, alpha: 1.0)
        let gradient = CAGradientLayer()
        gradient.colors = [black.cgColor, darkPurple.cgColor]
        gradient.locations = [0.0, 0.75, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = view.frame
        self.view.layer.insertSublayer(gradient, at: 0)
        
        // Tap to search label
        
        searchTitle.center.x = self.view.center.x
        searchTitle.center.y = 120
        searchTitle.textAlignment = .center
        searchTitle.text = "Tap to search"
        searchTitle.textColor = UIColor.white
        let sfont = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
        searchTitle.font = sfont

        self.view.addSubview(searchTitle)
        
        // Search Button
        // Push to send query to database
        // Sends two inputs - artist name and song name to find in database
        let searchBack = UIImage(named: "Search Button")
        searchButton.setImage(searchBack , for: .normal)
        searchButton.setTitle("Test Button", for: .normal)
        searchButton.addTarget(self, action: #selector(queryAction), for: .touchUpInside)
        self.view.addSubview(searchButton)
        searchButton.center.x = view.center.x

        
        
        
        // Artist name
        artistNameField.attributedPlaceholder = NSAttributedString(string: "Artist Name",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        artistNameField.textColor = UIColor.white
        artistNameField.font = UIFont(name: "HelveticaNeue-Light", size: 15.0)!
        artistNameField.borderStyle = UITextField.BorderStyle.roundedRect
        artistNameField.autocorrectionType = UITextAutocorrectionType.no
        artistNameField.keyboardType = UIKeyboardType.default
        artistNameField.returnKeyType = UIReturnKeyType.done
        artistNameField.clearButtonMode = UITextField.ViewMode.whileEditing;
        artistNameField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        artistNameField.delegate = self
        artistNameField.backgroundColor = UIColor.clear
        artistNameField.keyboardAppearance = UIKeyboardAppearance.dark;
        self.view.addSubview(artistNameField)
        
        let artistBorder = CALayer()
        let width = CGFloat(2.0)
        artistBorder.borderColor = UIColor.lightGray.cgColor
        artistBorder.frame = CGRect(x: 0, y: artistNameField.frame.size.height - width, width: artistNameField.frame.size.width, height: artistNameField.frame.size.height)
        
        artistBorder.borderWidth = width
        artistNameField.layer.addSublayer(artistBorder)
        artistNameField.layer.masksToBounds = true
        
        
        // Song name
        songNameField.attributedPlaceholder = NSAttributedString(string: "Song Name",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        songNameField.textColor = UIColor.white
        songNameField.font = UIFont(name: "HelveticaNeue-Light", size: 15.0)!
        songNameField.borderStyle = UITextField.BorderStyle.roundedRect
        songNameField.autocorrectionType = UITextAutocorrectionType.no
        songNameField.keyboardType = UIKeyboardType.default
        songNameField.returnKeyType = UIReturnKeyType.done
        songNameField.clearButtonMode = UITextField.ViewMode.whileEditing;
        songNameField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        songNameField.delegate = self
        songNameField.backgroundColor = UIColor.clear
        songNameField.keyboardAppearance = UIKeyboardAppearance.dark;
        self.view.addSubview(songNameField)

        let songBorder = CALayer()
        songBorder.borderColor = UIColor.lightGray.cgColor
        songBorder.frame = CGRect(x: 0, y: songNameField.frame.size.height - width, width: songNameField.frame.size.width, height: songNameField.frame.size.height)
        
        songBorder.borderWidth = width
        songNameField.layer.addSublayer(songBorder)
        songNameField.layer.masksToBounds = true

        let defaultAlbum = "defaultAlbum.png"
        let albumImage = UIImage(named: defaultAlbum)
        let albumView = UIImageView(image: albumImage!)
        albumView.frame = CGRect(x: 0, y: 150, width: 120, height: 120)
        view.addSubview(albumView)
        albumView.center.x = view.center.x
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func queryAction(sender: UIButton!) {
        print("Search query")
        let artistName = artistNameField.text
        let songName = songNameField.text
        
        print("artist: "+artistName!)
        print("song: "+songName!)
        
        artistNameField.text = "";
        songNameField.text = "";
    }
    
    override func touchesBegan(_ touches:Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        //or
        self.view.endEditing(true)
        return true
    }
    
    

}



