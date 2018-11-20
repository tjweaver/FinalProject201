//
//  LoginViewController.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 11/19/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var isAlreadyAUser = false;
    let loginTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 35))
    let toggleSignin = UIButton(frame: CGRect(x: 30, y: 280, width: 110, height: 50))
    let guestSignin = UIButton(frame: CGRect(x: 70, y: 480, width: 110, height: 50))
    let submitButton = UIButton(frame: CGRect(x: 190, y: 480, width: 105, height: 50))
    let userNameTextField =  UITextField(frame: CGRect(x: 30, y: 350, width: 300, height: 40))
    let passwordTextField =  UITextField(frame: CGRect(x: 30, y: 410, width: 300, height: 40))
    let rePasswordTextField =  UITextField(frame: CGRect(x: 30, y: 470, width: 300, height: 40))

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action:Selector(“endEditing:”)))
        let tap = UITapGestureRecognizer(target: self.view, action: Selector(“endEditing:”))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
 
 */
        

        // Do any additional setup after loading the view.
        
        // Background visuals
        let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        let darkPurple = UIColor(red: 24/255.0, green: 18/255.0, blue: 97/255.0, alpha: 1.0)
        let betterBlue = UIColor(red: 0/255.0, green: 94/255.0, blue: 255/255.0, alpha: 1.0)
        let brightPurple = UIColor(red: 169/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1.0)

        let gradient = CAGradientLayer()
        gradient.colors = [black.cgColor, darkPurple.cgColor]
        gradient.locations = [0.0, 0.75, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = view.frame
        self.view.layer.insertSublayer(gradient, at: 0)
        
        
        
        let logoIcon = UIImage(named: "Search Button")
        let logoView = UIImageView(image: logoIcon!)
        logoView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        logoView.center = self.view.center;
        self.view.addSubview(logoView)

        
        UIView.animate(withDuration: 1.5, animations: {
           logoView.frame.origin.y -= 250
        }, completion:nil)
        
        //let loginTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 35))
        loginTitle.center.x = self.view.center.x
        loginTitle.center.y = 230
        loginTitle.textAlignment = .center
        loginTitle.text = "Login"
        loginTitle.textColor = UIColor.white
        let sfont = UIFont(name: "HelveticaNeue-Medium", size: 30.0)!
        loginTitle.font = sfont
        loginTitle.alpha = CGFloat(0)

        
        self.view.addSubview(loginTitle)
        
        UIView.animate(withDuration: 1.5, delay: 1.5, animations: {
            self.loginTitle.alpha = CGFloat(1)
        }, completion:nil)
        
        
        
        
        //toggleSignin.center = self.view.center
        toggleSignin.titleLabel?.textColor = UIColor.white
        toggleSignin.center.x = view.center.x
        let tfont = UIFont(name: "HelveticaNeue", size: 15.0)!
        toggleSignin.titleLabel?.font = tfont
        toggleSignin.layer.cornerRadius = 5
        toggleSignin.layer.borderWidth = 1
        toggleSignin.layer.borderColor = UIColor.white.cgColor
        toggleSignin.setTitle("New?", for: .normal)
        toggleSignin.backgroundColor = darkPurple;
        
        toggleSignin.addTarget(self, action: #selector(toggleAction), for: .touchUpInside)
        self.view.addSubview(toggleSignin)
        toggleSignin.alpha = CGFloat(0)
        UIView.animate(withDuration: 1.5, delay: 1.5, animations: {
            self.toggleSignin.alpha = CGFloat(1)
        }, completion:nil)
        
        guestSignin.titleLabel?.textColor = UIColor.white
        guestSignin.titleLabel?.font = tfont
        guestSignin.layer.cornerRadius = 5
        guestSignin.layer.borderWidth = 1
        guestSignin.layer.borderColor = UIColor.white.cgColor
        guestSignin.setTitle("Guest >", for: .normal)
        guestSignin.backgroundColor = betterBlue;
        guestSignin.addTarget(self, action: #selector(guestActionSignin), for: .touchUpInside)
        self.view.addSubview(guestSignin)
        guestSignin.alpha = CGFloat(0)
        UIView.animate(withDuration: 1.5, delay: 1.5, animations: {
            self.guestSignin.alpha = CGFloat(1)
        }, completion:nil)
        
        let gradientLayer2 = CAGradientLayer()
        gradientLayer2.frame = guestSignin.bounds
        gradientLayer2.colors = [betterBlue.cgColor, brightPurple.cgColor]
        guestSignin.layer.insertSublayer(gradientLayer2, at: 0)
        
        submitButton.titleLabel?.textColor = UIColor.white

        submitButton.titleLabel?.font = tfont
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.white.cgColor
        submitButton.setTitle("Submit >", for: .normal)
        submitButton.backgroundColor = betterBlue;
        submitButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        self.view.addSubview(submitButton)
        submitButton.alpha = CGFloat(0)
        UIView.animate(withDuration: 1.5, delay: 1.5, animations: {
            self.submitButton.alpha = CGFloat(1)
        }, completion:nil)
        
        let gradientLayer3 = CAGradientLayer()
        gradientLayer3.frame = submitButton.bounds
        gradientLayer3.colors = [betterBlue.cgColor, brightPurple.cgColor]
        submitButton.layer.insertSublayer(gradientLayer3, at: 0)

        userNameTextField.delegate = self as? UITextFieldDelegate
        userNameTextField.placeholder = "Username"
        userNameTextField.font = UIFont.systemFont(ofSize: 15)
        userNameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        userNameTextField.autocorrectionType = UITextAutocorrectionType.no
        userNameTextField.keyboardType = UIKeyboardType.default
        userNameTextField.returnKeyType = UIReturnKeyType.done
        userNameTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        userNameTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        userNameTextField.delegate = self as? UITextFieldDelegate
        self.view.addSubview(userNameTextField)
        userNameTextField.alpha = CGFloat(0)
        UIView.animate(withDuration: 1.5, delay: 1.6, animations: {
            self.userNameTextField.alpha = CGFloat(1)
        }, completion:nil)

        passwordTextField.delegate = self as? UITextFieldDelegate
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 15)
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        passwordTextField.delegate = self as? UITextFieldDelegate
        self.view.addSubview(passwordTextField)
        passwordTextField.alpha = CGFloat(0)
        UIView.animate(withDuration: 1.5, delay: 1.6, animations: {
            self.passwordTextField.alpha = CGFloat(1)
        }, completion:nil)
        
        rePasswordTextField.delegate = self as? UITextFieldDelegate
        rePasswordTextField.placeholder = "Reenter Password"
        rePasswordTextField.font = UIFont.systemFont(ofSize: 15)
        rePasswordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        rePasswordTextField.autocorrectionType = UITextAutocorrectionType.no
        rePasswordTextField.keyboardType = UIKeyboardType.default
        rePasswordTextField.returnKeyType = UIReturnKeyType.done
        rePasswordTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        rePasswordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        rePasswordTextField.delegate = self as? UITextFieldDelegate
        self.view.addSubview(rePasswordTextField)
        rePasswordTextField.isHidden = true

        
    }
    
    @objc func toggleAction(sender: UIButton!) {
        print("Switch")
        
        isAlreadyAUser = !isAlreadyAUser
        
        if(isAlreadyAUser == true)
        {
            sender.setTitle("Already a user?", for: UIControl.State.normal)
            //toggleSignin.frame = (frame: CGRect(x: 100, y: 100, width: 250, height: 100)) as! CGRect
            toggleSignin.frame.size.width = 130;
            toggleSignin.center.x = view.center.x;
            loginTitle.text = "Register"
            rePasswordTextField.isHidden = false
            guestSignin.center.y = 550
            submitButton.center.y = 550

        }
        else
        {
            sender.setTitle("New?", for: .normal)
            //toggleSignin.frame = (frame: CGRect(x: 100, y: 100, width: 250, height: 100)) as! CGRect
            toggleSignin.frame.size.width = 110;
            toggleSignin.center.x = view.center.x;
            rePasswordTextField.isHidden = true
            guestSignin.center.y = 500
            submitButton.center.y = 500
            loginTitle.text = "Login"
        }
    }
    
    @objc func guestActionSignin(sender: UIButton!) {
        print("Guest login")

    }
    
    @objc func submitAction(sender: UIButton!) {
        print("Submitting user info")
        
    }
    
    override func touchesBegan(_ touches:Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        //or
        self.view.endEditing(true)
        return true
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
