//
//  FirstViewController.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 10/29/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
// EXPLORE

import UIKit

class ExploreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        let darkPurple = UIColor(red: 24/255.0, green: 18/255.0, blue: 97/255.0, alpha: 1.0)
        let gradient = CAGradientLayer()
        gradient.colors = [black.cgColor, darkPurple.cgColor]
        gradient.locations = [0.0, 0.75, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = view.frame
        self.view.layer.insertSublayer(gradient, at: 0)
        
        let exploreTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        exploreTitle.center.x = self.view.center.x
        exploreTitle.center.y = 170
        exploreTitle.textAlignment = .center
        exploreTitle.text = "Explore"
        exploreTitle.textColor = UIColor.white
        let sfont = UIFont(name: "HelveticaNeue-Bold", size: 50.0)!
        exploreTitle.font = sfont
        
        self.view.addSubview(exploreTitle)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    


}

