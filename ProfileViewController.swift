//
//  ProfileViewController.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 10/29/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    let userNameTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 35))
    let maskView = UIImageView()
    var profilePicView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maskView.image = UIImage(named: "mask.png")

        var profileDefault = "bigGuest.png"
        if(Main().getGuestBool() == false)
        {
            profileDefault = "jay.png"
        }
        let profilePic = UIImage(named: profileDefault)
        profilePicView = UIImageView(image: profilePic!)
        profilePicView.mask = maskView
        profilePicView.frame = CGRect(x: 0, y: 150, width: 120, height: 120)
        view.addSubview(profilePicView)
        profilePicView.center.x = view.center.x
        
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
        
        userNameTitle.center.x = self.view.center.x
        userNameTitle.center.y = 120
        userNameTitle.textAlignment = .center
        //userNameTitle.text = "f"
        self.setUsernameTitle()
        //userNameTitle.text = "yer"
        userNameTitle.textColor = UIColor.white
        let sfont = UIFont(name: "HelveticaNeue-Medium", size: 30.0)!
        userNameTitle.font = sfont
        
        self.view.addSubview(userNameTitle)
        
        /*
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .green
        button.setTitle("Test Button", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)*/
        
        //self.view.addSubview(button)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }

    func setUsernameTitle()
    {
        print(Main().getGuestBool())
        if(Main().getGuestBool() == true)
        {
            userNameTitle.text = "Guest"
        }
        else
        {
            userNameTitle.text = Main().getUsername()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        maskView.frame = profilePicView.bounds
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        //segue.destination = LoginViewController()
        // Pass the selected object to the new view controller.
        
    }
 

}
