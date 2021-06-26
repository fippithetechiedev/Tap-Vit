//
//  register.swift
//  Tap
//
//  Created by Philip George on 25/08/18.
//  Copyright © 2018 Sarvad shetty. All rights reserved.
//
import UIKit

var dataflag = 0
class registerVC: UIViewController {
    
    //MARK:IBOutlets
    @IBOutlet weak var regno: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var act: UIActivityIndicatorView!
    
    
    
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
        
        act.layer.opacity = 0
        regno.autocorrectionType = .no
        password.autocorrectionType = .no
        // Do any additional setup after loading the view.
        if(reset == 1)
        {
            regno.text = UserDefaults.standard.string(forKey: "Username")
            regno.isUserInteractionEnabled = false
            
        }
        else
        {
            regno.isUserInteractionEnabled = true
        }
        textFieldSetup()
    }

    
    
    
    //MARK:IBActions
    func createalert(title:String, message:String)
    {
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.actionSheet)
        
        
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        }))
        
        
        
        alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.destructive, handler: { (action) in
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL.init(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }

            alert.dismiss(animated: true, completion: nil)
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }

    func createalert2(title:String, message:String)
    {
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.actionSheet)
        
        
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        }))
        
        
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func loginpressed(_ sender: Any) {
        
        URLCache.shared.removeAllCachedResponses()
        check()
    }
    
    
    func check()
    {
        if(regno.text == "" || password.text == "")
        {
            createalert2(title: "Error", message: "Please fill in all fields.")
        }
        else if(regno.text != "" && password.text != "")
        {
            login.isUserInteractionEnabled = false
            login.setTitle("W A I T", for: .normal)

            
            URLCache.shared.removeAllCachedResponses()

            act.startAnimating()
            act.layer.opacity = 1
//            Request.shared.LogoutApi { (String) in
//                print("yolo\(stat)")
            
            
            Request.shared.LogoutApi(result: { (String) in
                
         
           if reset == 1
           {
            
            Request.shared.connectionChecker { (String) in
                
                print("status \(status)")
                
                if(status=="nointvit")
                {
                    print("entered")
                    
                    //Request.shared.LogoutApi { (result) in
                    //                print(result)
                    
                    //                Request.shared.LogoutApi(result: { (String) in
                    
                    Request.shared.LoginApi(userId: self.regno.text!, password: self.password.text!, mode: 0) { (code) in
                        //print(code)
                        print("THE \(code)")
                        
                        //{
                        if(code == 1)
                        {
                            flag = 1
                            UserDefaults.standard.set(self.password.text, forKey: "password")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                // Put your code which should be executed with a delay here
                                
                                //                            Request.shared.checkCurrentUsage(usage: { (code) in
                                
                                //                                print("hey\(code)")
                                
                                self.act.stopAnimating()
                                self.act.layer.opacity = 0
                                self.performSegue(withIdentifier: "registertomain", sender: self)
                                
                                //                            })
                            })
                            //                        }
                        }
                            
                        else if(code == 0)
                        {
                            self.act.stopAnimating()
                            self.act.layer.opacity = 0
                            self.createalert2(title: "Error", message: "If the password entered is correct, ensure that you are logged out of all other devices & try again.")
                            self.login.isUserInteractionEnabled = true
                            self.login.setTitle("S A V E", for: .normal)
                            
                        }
                        else if(code == 2)
                        {
                            self.act.stopAnimating()
                            self.act.layer.opacity = 0
                            self.createalert(title: "Error", message: "Please connect to a VIT Wi-Fi network. Wait for the WiFi symbol to appear on the status bar. Retry if connected.")
                            
                            self.login.isUserInteractionEnabled = true
                            self.login.setTitle("S A V E", for: .normal)
                            
                        }
                        //                    else if(code == 2 && status == "nointvit")
                        //                    {
                        //                        flag = 1
                        //                        UserDefaults.standard.set(self.regno.text, forKey: "Username")
                        //                        UserDefaults.standard.set(self.password.text, forKey: "password")
                        //
                        //                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        //                            // Put your code which should be executed with a delay here
                        //
                        //                            Request.shared.checkCurrentUsage(usage: { (code) in
                        //
                        //                                print("hey\(code)")
                        //                                self.performSegue(withIdentifier: "registertomain", sender: self)
                        //
                        //                            })
                        //
                        //                        })
                        //                    }
                    } // })
                    // }//logoutapi end
                }
                else if(status == "intvit")
                {   self.act.stopAnimating()
                    self.act.layer.opacity = 0
                    URLCache.shared.removeAllCachedResponses()
                    self.createalert2(title: "Error", message: "Oops! Looks like you're already logged in. Try again.")
                    self.login.isUserInteractionEnabled = true
                    self.login.setTitle("S A V E", for: .normal)
                    
                    
                }
                else if(status == "noconnect" || status == "ondata")
                {
                    self.act.stopAnimating()
                    self.act.layer.opacity = 0
                    self.createalert(title: "Error", message: "Please connect to a VIT Wi-Fi network. Wait for the WiFi symbol to appear on the status bar. Retry if connected.")
                    self.login.isUserInteractionEnabled = true
                    self.login.setTitle("S A V E", for: .normal)
                }
                
                
                
                
            }
           
           }
            
           else //decide
           
           {
                
                
                
            Request.shared.connectionChecker { (String) in
                
                print("status \(status)")
          
            if(status=="nointvit")
            {
                print("entered")

            //Request.shared.LogoutApi { (result) in
//                print(result)

//                Request.shared.LogoutApi(result: { (String) in

                Request.shared.LoginApi(userId: self.regno.text!, password: self.password.text!, mode: 0) { (code) in
                    //print(code)
                    print("THE \(code)")

                    //{
                    if(code == 1)
                    {
                        flag = 1
                        UserDefaults.standard.set(self.regno.text, forKey: "Username")
                        UserDefaults.standard.set(self.password.text, forKey: "password")

                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            // Put your code which should be executed with a delay here

//                            Request.shared.checkCurrentUsage(usage: { (code) in

//                                print("hey\(code)")
                            
                            self.act.stopAnimating()
                            self.act.layer.opacity = 0
                            UserDefaults.standard.set("-", forKey: "dataUsage")
                            UserDefaults.init(suiteName:"group.Fippinew.TAP")?.setValue("-", forKey: "widgetUsage")
                                self.performSegue(withIdentifier: "registertomain", sender: self)

//                            })
                        })
//                        }
                    }

                    else if(code == 0)
                    {
                        self.act.stopAnimating()
                        self.act.layer.opacity = 0
                        self.createalert2(title: "Error", message: "Wrong Username/Password. If the password entered is correct, ensure that you are logged out of all other devices & try again.")
                        self.login.isUserInteractionEnabled = true
                        self.login.setTitle("S A V E", for: .normal)

                    }
                    else if(code == 2)
                    {
                        self.act.stopAnimating()
                        self.act.layer.opacity = 0
                        self.createalert(title: "Error", message: "Please connect to a VIT Wi-Fi network. Wait for the WiFi symbol to appear on the status bar. Retry if connected.")
                        
                        self.login.isUserInteractionEnabled = true
                        self.login.setTitle("S A V E", for: .normal)

                    }
//                    else if(code == 2 && status == "nointvit")
//                    {
//                        flag = 1
//                        UserDefaults.standard.set(self.regno.text, forKey: "Username")
//                        UserDefaults.standard.set(self.password.text, forKey: "password")
//
//                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//                            // Put your code which should be executed with a delay here
//
//                            Request.shared.checkCurrentUsage(usage: { (code) in
//
//                                print("hey\(code)")
//                                self.performSegue(withIdentifier: "registertomain", sender: self)
//
//                            })
//
//                        })
//                    }
                } // })
           // }//logoutapi end
            }
            else if(status == "intvit")
            {   self.act.stopAnimating()
                self.act.layer.opacity = 0
                URLCache.shared.removeAllCachedResponses()
                self.createalert2(title: "Error", message: "Oops! Looks like you're already logged in. Try again.")
                self.login.isUserInteractionEnabled = true
                self.login.setTitle("S A V E", for: .normal)
                
                
            }
            else if(status == "noconnect" || status == "ondata")
            {
                self.act.stopAnimating()
                self.act.layer.opacity = 0
                self.createalert(title: "Error", message: "Please connect to a VIT Wi-Fi network. Wait for the WiFi symbol to appear on the status bar. Retry if connected.")
                self.login.isUserInteractionEnabled = true
                self.login.setTitle("S A V E", for: .normal)
            }
            

                

                }//end of checkconnection
                }
                
            })

            }
    
            }
//            Request.shared.LoginApi(userId: regno.text!, password: password.text!) { (code) in
//
//                if(flag == 1)
//                {
            
//                    UserDefaults.standard.set(self.regno.text, forKey: "Username")
//                    UserDefaults.standard.set(self.password.text, forKey: "password")
//
//                    Request.shared.connectionChecker { (stats) in
//                        if stats == "You are already logged in"{
//                            flag = 1
//                            //stop
//                            //                     self.performSegue(withIdentifier: "goToMain", sender: nil)
//                            Request.shared.LogoutApi(result: { (_) in
//                                Request.shared.LoginApi(userId: UserDefaults.standard.string(forKey: "Username")!, password: UserDefaults.standard.string(forKey: "password")!, result: { (_) in
//                                    flag = 1
//                                    self.performSegue(withIdentifier: "registertomain", sender: self)
//
//                                })
//                            })
//                        }else{
//
//                            flag = 0
//                            self.performSegue(withIdentifier: "registertomain", sender: self)
//                        }
//                    }
//
//                }
//            }
                }
            //}
            
    
            
    
    
//}



extension registerVC:UITextFieldDelegate{
    func textFieldSetup(){
        regno.delegate = self
        password.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == regno{
            regno.resignFirstResponder()
            password.becomeFirstResponder()
        }
        else if textField == password{
            textField.resignFirstResponder()
        }
        
        return true
    }
}
