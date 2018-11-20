//
//  SecondViewController.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 10/29/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
// SEARCH

import UIKit

class SearchViewController: UIViewController {

    // chainable animator
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        let searchTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
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
        let searchButton = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        searchButton.setImage(searchBack , for: .normal)
        searchButton.center = self.view.center
        searchButton.setTitle("Test Button", for: .normal)
        searchButton.addTarget(self, action: #selector(queryAction), for: .touchUpInside)
        self.view.addSubview(searchButton)

        let sampleTextField =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        sampleTextField.placeholder = "Artist"
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        sampleTextField.delegate = self as? UITextFieldDelegate
        self.view.addSubview(sampleTextField)
        
        let sampleTextField2 =  UITextField(frame: CGRect(x: 20, y: 160, width: 300, height: 40))
        sampleTextField2.placeholder = "Song name"
        sampleTextField2.font = UIFont.systemFont(ofSize: 15)
        sampleTextField2.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField2.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField2.keyboardType = UIKeyboardType.default
        sampleTextField2.returnKeyType = UIReturnKeyType.done
        sampleTextField2.clearButtonMode = UITextField.ViewMode.whileEditing;
        sampleTextField2.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        sampleTextField2.delegate = self as? UITextFieldDelegate
        self.view.addSubview(sampleTextField2)

        // Artist name text field
        /*
        let artistNameField =  UITextField(frame: CGRect(x: 20, y: 150, width: 300, height: 40))
        artistNameField.placeholder = "Artist Name"
        artistNameField.font = UIFont.systemFont(ofSize: 15)
        artistNameField.borderStyle = UITextField.BorderStyle.roundedRect
        artistNameField.autocorrectionType = UITextAutocorrectionType.no
        artistNameField.keyboardType = UIKeyboardType.default
        artistNameField.returnKeyType = UIReturnKeyType.done
        artistNameField.clearButtonMode = UITextField.ViewMode.whileEditing;
        artistNameField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        artistNameField.delegate = self as? UITextFieldDelegate
        self.view.addSubview(artistNameField)*/
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func songSelection(sender: UIButton!) {
        print("Song select")
    }
    
    @objc func queryAction(sender: UIButton!) {
        print("Search query")
    }
    
    
    

}




// Select song
/*
 let songSelectButton = UIButton(frame: CGRect(x: 100, y: 240, width: 150, height: 20))
 songSelectButton.backgroundColor = UIColor.lightGray
 //songSelectButton.center = self.view.center
 songSelectButton.setTitle("Select Song", for: .normal)
 let smallfont = UIFont(name: "HelveticaNeue-Bold", size: 18.0)!
 songSelectButton.titleLabel?.font = smallfont
 songSelectButton.addTarget(self, action: #selector(songSelection(sender:)), for: .touchUpInside)
 self.view.addSubview(songSelectButton)*/
