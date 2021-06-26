//
//  AddPrepaidCardViewController.swift
//  Tap
//
//  Created by Sarvad shetty on 8/26/18.
//  Copyright © 2018 Sarvad shetty. All rights reserved.
//

import UIKit

class AddPrepaidCardViewController: UIViewController, UITextFieldDelegate {

    //MARK:IBOutlets:
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var ac: UIActivityIndicatorView!
    @IBOutlet weak var updateButton: UIButton!
    
    @IBAction func back(_ sender: Any) {
        performSegue(withIdentifier: "update2settings", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 12.0, *) {
            if(traitCollection.userInterfaceStyle == .dark)
            {
                view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }
            else
            {
                view.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
                
            }
        }
        else {
            //no dark mode available before iOS 12.0
            
            // Fallback on earlier versions
        }
        
//        if let x = UserDefaults.standard.string(forKey: "card")
//        {
//        self.lab.text = "L A S T  A D D E D : - \(x)"
//        }
        // Do any additional setup after loading the view.
        confirmPassword.delegate = self
        newPassword.delegate = self
        currentPassword.delegate = self
        observeNotification()
    }
    override func viewDidAppear(_ animated: Bool) {
        logsin()
    }
    
    //MARK:IBActions:
    @IBAction func addButtonPressed(_ sender: UIButton) {
        URLCache.shared.removeAllCachedResponses()

        if currentPassword.text != "" && newPassword.text != "" && confirmPassword.text != ""{
            
            if currentPassword.text == UserDefaults.standard.string(forKey: "password"){
                if newPassword.text  == confirmPassword.text{
                    updateButton.setTitle("WAIT", for: .normal)
                    ac.layer.opacity = 1
                    ac.startAnimating()
                    Request.shared.changePassword(changeUserId: UserDefaults.standard.string(forKey: "Username")!, changePassword: currentPassword.text!, changeNewPassword: newPassword.text!, changeConfirmNewPassword: confirmPassword.text!) { (result) in
                        if result == "Password information has been updated successfully."{
                            self.ac.layer.opacity = 0
                            self.ac.stopAnimating()
                            self.updateButton.setTitle("UPDATE", for: .normal)
                            let alert = UIAlertController(title: "Success", message: "Password Updated.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Done", style: .default, handler:nil))
                            UserDefaults.standard.set(self.newPassword.text, forKey: "password")
                            self.present(alert, animated: true, completion: nil)
                            self.currentPassword.text = ""
                            self.newPassword.text = ""
                            self.confirmPassword.text = ""
                        }else{
                             self.updateButton.setTitle("UPDATE", for: .normal)
                            self.ac.layer.opacity = 0
                            self.ac.stopAnimating()
                            let alert = UIAlertController(title: "Error", message: "Unable to update. Try Logging out, Logging in through the app & then try changing the password.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
                                self.currentPassword.text = ""
                                self.newPassword.text = ""
                                self.confirmPassword.text = ""
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }else{
                    let alert = UIAlertController(title: "Error", message: "New password should match the confirm password.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (_) in
                        self.currentPassword.text = ""
                        self.newPassword.text = ""
                        self.confirmPassword.text = ""
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
                let alert = UIAlertController(title: "Error", message: "Enter correct current password.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (_) in
                    self.currentPassword.text = ""
                    self.newPassword.text = ""
                    self.confirmPassword.text = ""
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
        }else{
            let alert = UIAlertController(title: "Error", message: "Fill in all fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (_) in
                self.currentPassword.text = ""
                self.newPassword.text = ""
                self.confirmPassword.text = ""
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        URLCache.shared.removeAllCachedResponses()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == currentPassword{
            newPassword.becomeFirstResponder()
        }
        else if textField == newPassword{
            confirmPassword.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
    
    private func observeNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardShow(){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -130, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
        
    }
    @objc func keyboardWillHide(){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    
    
    func logsin(){
        ac.layer.opacity = 1
        ac.startAnimating()
         URLCache.shared.removeAllCachedResponses()
        
        Request.shared.connectionChecker { (stats) in
            print(stats)
            if (stats == "noconnect" || stats == "ondata"){
                self.ac.layer.opacity = 0
                self.ac.stopAnimating()
                 self.createalert(title: "Error", message: "Please connect to a VIT Wi-Fi network. Wait for the WiFi symbol to appear on the status bar. Retry if connected.")
                
            }else if stats == "nointvit"{
                let username = UserDefaults.standard.string(forKey: "Username")
                let password = UserDefaults.standard.string(forKey: "password")
                Request.shared.LoginApi(userId: username! , password: password!, mode: 0) { (code) in
                    print("password code\(code)")
                    self.ac.layer.opacity = 0
                    self.ac.stopAnimating()
                }
            }else{
                self.ac.layer.opacity = 0
                self.ac.stopAnimating()
            }
            URLCache.shared.removeAllCachedResponses()

        }
        URLCache.shared.removeAllCachedResponses()

    }
    
    
    
    func createalert(title:String, message:String)
    {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.actionSheet)
        
        
        
        alert.addAction(UIAlertAction(title: "R E T R Y", style: UIAlertActionStyle.default, handler: { (action) in
            
            self.logsin()
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

}
