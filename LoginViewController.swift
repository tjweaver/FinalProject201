//
//  LoginViewController.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 11/19/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setPadding()
    {
        let padView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = padView
        self.leftViewMode = .always
    }
    
    func setBottomBorder()
    {
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var isAlreadyAUser = false
    var isGuest = false
    let loginTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 35))
    let errorPasswordMessage = UILabel(frame: CGRect(x: 30, y: 580, width: 200, height: 35))
    let toggleSignin = UIButton(frame: CGRect(x: 30, y: 280, width: 110, height: 50))
    let guestSignin = UIButton(frame: CGRect(x: 70, y: 480, width: 110, height: 50))
    let submitButton = UIButton(frame: CGRect(x: 190, y: 480, width: 105, height: 50))
    let userNameTextField =  UITextField(frame: CGRect(x: 30, y: 350, width: 300, height: 40))
    let passwordTextField =  UITextField(frame: CGRect(x: 30, y: 410, width: 300, height: 40))
    let rePasswordTextField =  UITextField(frame: CGRect(x: 30, y: 470, width: 300, height: 40))
    public var userTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let errorFont = UIFont(name: "HelveticaNeue", size: 15.0)!
        errorPasswordMessage.text = "Passwords do not match"
        errorPasswordMessage.textColor = UIColor.red
        errorPasswordMessage.font = errorFont
        errorPasswordMessage.alpha = 0.0
        self.view.addSubview(errorPasswordMessage)
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

        //userNameTextField.placeholder = "Username"
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        userNameTextField.textColor = UIColor.white
        //userNameTextField.keyboardAppearance = UIKeyboardAppearance.dark;
        userNameTextField.font = UIFont(name: "HelveticaNeue-Light", size: 15.0)!
        userNameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        userNameTextField.autocorrectionType = UITextAutocorrectionType.no
        userNameTextField.keyboardType = UIKeyboardType.default
        userNameTextField.returnKeyType = UIReturnKeyType.done
        userNameTextField.autocapitalizationType = .none
        userNameTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        userNameTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        userNameTextField.delegate = self
        userNameTextField.backgroundColor = UIColor.clear
        self.view.addSubview(userNameTextField)
        userNameTextField.alpha = CGFloat(0)
        UIView.animate(withDuration: 1.5, delay: 1.6, animations: {
            self.userNameTextField.alpha = CGFloat(1)
        }, completion:nil)

        let userBorder = CALayer()
        let width = CGFloat(2.0)
        userBorder.borderColor = UIColor.lightGray.cgColor
        userBorder.frame = CGRect(x: 0, y: userNameTextField.frame.size.height - width, width: userNameTextField.frame.size.width, height: userNameTextField.frame.size.height)
        
        userBorder.borderWidth = width
        userNameTextField.keyboardAppearance = UIKeyboardAppearance.dark;
        userNameTextField.layer.addSublayer(userBorder)
        userNameTextField.layer.masksToBounds = true
        
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.textColor = UIColor.white
        passwordTextField.backgroundColor = UIColor.clear

        passwordTextField.placeholder = "Password"
        passwordTextField.keyboardAppearance = UIKeyboardAppearance.dark;
        passwordTextField.font = UIFont(name: "HelveticaNeue-Light", size: 15.0)!
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.autocapitalizationType = .none
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.isSecureTextEntry = true
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        passwordTextField.delegate = self
        self.view.addSubview(passwordTextField)
        passwordTextField.alpha = CGFloat(0)
        UIView.animate(withDuration: 1.5, delay: 1.6, animations: {
            self.passwordTextField.alpha = CGFloat(1)
        }, completion:nil)
        
        let passBorder = CALayer()
        passBorder.borderColor = UIColor.lightGray.cgColor
        passBorder.frame = CGRect(x: 0, y: passwordTextField.frame.size.height - width, width: passwordTextField.frame.size.width, height: passwordTextField.frame.size.height)
        
        passBorder.borderWidth = width
        passwordTextField.keyboardAppearance = UIKeyboardAppearance.dark;
        passwordTextField.layer.addSublayer(passBorder)
        passwordTextField.layer.masksToBounds = true

        
        rePasswordTextField.delegate = self
        rePasswordTextField.attributedPlaceholder = NSAttributedString(string: "Reenter Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        rePasswordTextField.textColor = UIColor.white
        rePasswordTextField.backgroundColor = UIColor.clear
        rePasswordTextField.placeholder = "Reenter Password"
        rePasswordTextField.font = UIFont(name: "HelveticaNeue-Light", size: 15.0)!
        rePasswordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        rePasswordTextField.autocorrectionType = UITextAutocorrectionType.no
        rePasswordTextField.keyboardType = UIKeyboardType.default
        rePasswordTextField.autocapitalizationType = .none
        rePasswordTextField.isSecureTextEntry = true
        rePasswordTextField.returnKeyType = UIReturnKeyType.done
        rePasswordTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        rePasswordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.view.addSubview(rePasswordTextField)
        rePasswordTextField.isHidden = true

        
        let repassBorder = CALayer()
        repassBorder.borderColor = UIColor.lightGray.cgColor
        repassBorder.frame = CGRect(x: 0, y: rePasswordTextField.frame.size.height - width, width: rePasswordTextField.frame.size.width, height: rePasswordTextField.frame.size.height)
         
        repassBorder.borderWidth = width
        rePasswordTextField.keyboardAppearance = UIKeyboardAppearance.dark;
        rePasswordTextField.layer.addSublayer(repassBorder)
        rePasswordTextField.layer.masksToBounds = true

        
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
        userTitle = "Guest"
        isGuest = true
        self.performSegue(withIdentifier: "TabSegue", sender: self)
        self.performSegue(withIdentifier: "LoginSegue", sender: self)

    }
    
    @objc func submitAction(sender: UIButton!) {
        print("Submitting user info")
        
        if(isAlreadyAUser != true)
        {
            let usernameInfo = userNameTextField.text
            let passwordInfo = passwordTextField.text
            
            print("user: "+usernameInfo!)
            print("password: "+passwordInfo!)
            
            Main().setUsername(name: usernameInfo!)
            self.performSegue(withIdentifier: "TabSegue", sender: self)
            self.performSegue(withIdentifier: "LoginSegue", sender: self)
            userNameTextField.text = "";
            passwordTextField.text = "";
        }
        else
        {
            let usernameInfo = userNameTextField.text
            let passwordInfo = passwordTextField.text
            let repasswordInfo = rePasswordTextField.text
            
            if(repasswordInfo != passwordInfo)
            {
                passwordDoNotMatch()
                print("passwords don't match")
                userNameTextField.text = "";
                passwordTextField.text = "";
                rePasswordTextField.text = "";
            }
            else
            {
                Main().setUsername(name: usernameInfo!)
                self.performSegue(withIdentifier: "TabSegue", sender: self)
                self.performSegue(withIdentifier: "LoginSegue", sender: self)
                print("user: "+usernameInfo!)
                print("password: "+passwordInfo!)
                print("repassword: "+repasswordInfo!)
                
                userNameTextField.text = "";
                passwordTextField.text = "";
                rePasswordTextField.text = "";
            }
        }
        

    }
    
    func passwordDoNotMatch()
    {
        UIView.animate(withDuration: 5.0, delay: 0.0, animations: {
            self.errorPasswordMessage.alpha = CGFloat(1)
            self.errorPasswordMessage.alpha = CGFloat(0)
        }, completion:nil)
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
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.destination is TabBarViewController)
        {
            let vc = segue.destination as? TabBarViewController
            if(isGuest == true)
            {
                Main().setGuestBool(val: true)
                Main().setUsername(name: "Guest")
                vc?.nameOfuser = "Guest"
            }
            else
            {
                Main().setGuestBool(val: false)
                vc?.nameOfuser = "Jay Doshi"
            }
        }
    }
    
    func getUserTitle() -> String
    {
        return userTitle
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
