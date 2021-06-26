//
//  lottieViewController.swift
//  Tap
//
//  Created by Sarvad shetty on 8/29/18.
//  Copyright © 2018 Sarvad shetty. All rights reserved.
//

import UIKit
import Lottie
import Alamofire

var flag = 0
var reset = 0

class lottieViewController: UIViewController {

    
  
    @IBOutlet weak var ind: UIActivityIndicatorView!
    
    
    let animview = LOTAnimationView(name: "vs")
    
    
    
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
        
        URLCache.shared.removeAllCachedResponses()

        
//        animview.loopAnimation = true
        animview.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        animview.contentMode = .scaleAspectFill
        
        self.view.addSubview(animview)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        URLCache.shared.removeAllCachedResponses()

        //start
        print("APPEARED")
        logsin()
    }
    
    func logsin(){
        
        URLCache.shared.removeAllCachedResponses()
        ind.startAnimating()

        if let _ = UserDefaults.standard.string(forKey: "Username"){
            print("username present")
            if UserDefaults.standard.bool(forKey: "autoLogin") == true{
                //for auto login on
                //to check for internet connection
            print("auto login on")
                Request.shared.connectionChecker { (stats) in
                   print(stats)
                    if stats == "intvit"{
                        print("already logged in")
                        flag = 1
                        //stop
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            // Put your code which should be executed with a delay here
                        
                            self.animview.play(completion: { (true) in

                            self.performSegue(withIdentifier: "goToMain", sender: nil)
                            })

                        })
                        }else if(stats == "nointvit"){
                        print("not logged in")

                            let username = UserDefaults.standard.string(forKey: "Username")
                            let password = UserDefaults.standard.string(forKey: "password")
                        
//                            Request.shared.LoginApi(userId: username!, password: password!,mode: 1, result: { (code) in
//                                if code == 200{
//                                    flag = 1
////                                    //stop
////                                    Request.shared.checkCurrentUsage(usage: { (String) in
////                                        print("checked")
////                                    })
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//                                        // Put your code which should be executed with a delay here
//
//                                        Request.shared.checkCurrentUsage(usage: { (String) in
//                                            if(stat == 200)
//                                            {
//                                                self.animview.play(completion: { (true) in
//
//                                                    self.performSegue(withIdentifier: "goToMain", sender: nil)
//                                                })
//                                            }
//                                        })
//
//                                    })
//                                }
//                            })

                        
                        Request.shared.LoginApi(userId: username! , password: password!, mode: 0) { (code) in
                            //print(code)
                            print("THE \(code)")
                            
                            //{
                            if(code == 1)
                            {
                                flag = 1
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                    // Put your code which should be executed with a delay here
                                    
//                                    Request.shared.checkCurrentUsage(usage: { (code) in
//
                                        print("hey\(code)")
                                    self.animview.play(completion: { (true) in
                                        //
                                                                                            self.performSegue(withIdentifier: "goToMain", sender: nil)
                                                                                        })

                                        
                                    })
//                                })
                                //                        }
                            }
                                
                            else if(code == 0)
                            {

                                reset = 1
                                    self.createalert2(title: "Error", message: "If the password hasn't been changed by you, ensure that you are logged out of all other devices & try again.")
                                
                            }
                            else if(code == 2)
                            {
                                self.createalert(title: "Error", message: "Please connect to a VIT Wi-Fi network. Wait for the WiFi symbol to appear on the status bar. Retry if connected.")
                              
                                
                                
                            }
                            else if(code == 4)
                            {
                                self.createalert3(title: "Error", message: "Oops! Looks like your subscription has expired. Click try again once you have renewed your plan.")
                                
                                
                                
                            }
                        }
                        
                        /////////////////////////////////////
                        ///////////////////////
                        ///////////
                        
                    }
                    else if(stats == "noconnect" || stats == "ondata")
                    {
                        self.ind.stopAnimating()
                        self.createalert(title: "Error", message: "Please connect to a VIT Wi-Fi network. Wait for the WiFi symbol to appear on the status bar. Retry if connected.")
                    }
                }
                
            }else{
                //for auto login off
                //to check for internet connection
                print("entered")
                print("auto login off")
                Request.shared.connectionChecker { (stats) in
                    if stats == "intvit"{
                        print("already logged in")
                        flag = 1
                        //stop
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            // Put your code which should be executed with a delay here
                        
                            self.animview.play(completion: { (true) in
                                
                                self.performSegue(withIdentifier: "goToMain", sender: nil)
                            })
                        })
                        }else if(stats == "nointvit"){
                         print("not logged in")
//                        let username = UserDefaults.standard.string(forKey: "Username")
//                        let password = UserDefaults.standard.string(forKey: "password")
//                        Request.shared.LoginApi(userId: username!, password: password!, result: { (code) in
//                            if code == 200{
//                                flag = 1
//                                self.performSegue(withIdentifier: "goToMain", sender: nil)
//                            }
//                        })
                        flag = 0
                        //stop
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            // Put your code which should be executed with a delay here
                        
                            self.animview.play(completion: { (true) in
                                
                                self.performSegue(withIdentifier: "goToMain", sender: nil)
                            })
                        })
                        
                        }
                    else if(stats == "noconnect" || stats == "ondata")
                    {
                        self.ind.stopAnimating()

                        self.createalert(title: "Error", message: "Please connect to a VIT Wi-Fi network. Wait for the WiFi symbol to appear on the status bar. Retry if connected.")
                    }
                }
                
            }
            
        }else{
            //stop
            print("username not present")
            
            
            
            URLCache.shared.removeAllCachedResponses()

            if(req == 1)
            {
                req = 0

                self.logsin()
            }
                // Put your code which should be executed with a delay here
                Request.shared.connectionChecker(connectStats: { (res) in
                   print(res)
                    if(res == "nointvit")
                    {
                        if let _ = UserDefaults.standard.string(forKey: "onBoard"){
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                self.animview.play(completion: { (true) in
                                    
                                    self.performSegue(withIdentifier: "toreg", sender: nil)
                                })
                            })
                        }else{
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                self.animview.play(completion: { (true) in
                                    
//                                    UserDefaults.standard.set("onBoardStarted", forKey: "onBoard")
                                    self.performSegue(withIdentifier: "onBoard", sender: nil)
                                })
                            })
                        }
                    }
                    else if(res == "intvit")
                    {
                        if let _ = UserDefaults.standard.string(forKey: "onBoard"){
                            Request.shared.LogoutApi(result: { (resp) in
                                if(stat == 200)
                                {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                        self.animview.play(completion: { (true) in
                                            
                                            self.performSegue(withIdentifier: "toreg", sender: nil)
                                        })
                                    })
                                    
                                }
                            })
                        }else{
                            Request.shared.LogoutApi(result: { (resp) in
                                if(stat == 200)
                                {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                        self.animview.play(completion: { (true) in
//                                            UserDefaults.standard.set("onBoardStarted", forKey: "onBoard")
                                            self.performSegue(withIdentifier: "onBoard", sender: nil)
                                        })
                                    })
                                    
                                }
                            })
                        }
                        
                        
                    }
                    else if(res == "noconnect" || res == "ondata")
                    {
//                        self.animview.play(completion: { (true) in
//
//                            self.performSegue(withIdentifier: "toreg", sender: nil)
//                        })

                        self.ind.stopAnimating()

                        self.createalert(title: "Error", message: "Please connect to a VIT Wi-Fi network. Wait for the WiFi symbol to appear on the status bar. Retry if connected.")
                    }
                })
                
        
//            })
            }
    }


    
    func createalert(title:String, message:String)
    {

        
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.actionSheet)
        

        alert.addAction(UIAlertAction(title: "R E T R Y", style: .default, handler: { (act) in
            
            self.logsin()
            
            
             alert.dismiss(animated: true, completion: nil)
        
        }))
    
    
        
        
        alert.addAction(UIAlertAction(title: "S E T T I N G S", style: UIAlertActionStyle.destructive, handler: { (action) in
            


            UIView.animate(withDuration: 0.2, animations: {

                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL.init(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }

            }, completion: { (true) in
                

                self.logsin()
                
            })

            alert.dismiss(animated: true, completion: nil)

        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    func createalert2(title:String, message:String)
    {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.actionSheet)
        
        
        
        alert.addAction(UIAlertAction(title: "U P D A T E", style: UIAlertActionStyle.default, handler: { (action) in
             self.performSegue(withIdentifier: "toreg", sender: nil)
            
        }))
        
        alert.addAction(UIAlertAction(title: "T R Y  A G A I N", style: UIAlertActionStyle.default, handler: { (action) in
            self.logsin()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func createalert3(title:String, message:String)
    {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.actionSheet)
        
        
        alert.addAction(UIAlertAction(title: "T R Y  A G A I N", style: UIAlertActionStyle.default, handler: { (action) in
            self.logsin()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func unwindtostart(_segue:UIStoryboardSegue)
    {
        viewDidLoad()
    }
    
}



//MARK:Helper Notes


//if autologin not on then go to take to main
//else login and take to tap


//UserDefaults.standard.set(regno.text, forKey: "Username")
//UserDefaults.standard.set(password.text, forKey: "password")
