//
//  MainViewController.swift
//  Tap
//
//  Created by Sarvad shetty on 8/23/18.
//  Copyright © 2018 Sarvad shetty. All rights reserved.
//

import UIKit
import SystemConfiguration
import Foundation




class MainViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    

    @IBOutlet weak var outerappscontainer: UIView!
    
    let img = ["safari","in","wh","fb","snp","tw","yt","net","msc"]
    let applinks = ["x-web-search://","instagram://?app","whatsapp://?app","fb://?app","snapchat://?app","twitter://?app","youtube://?app","nflx://?app","music://?app"]
    let storelinks = ["https://www.google.com","https://itunes.apple.com/in/app/instagram/id389801252?mt=8","https://itunes.apple.com/in/app/whatsapp-messenger/id310633997?mt=8","https://itunes.apple.com/in/app/facebook/id284882215?mt=8","https://itunes.apple.com/in/app/snapchat/id447188370?mt=8","https://itunes.apple.com/in/app/twitter/id333903271?mt=8","https://itunes.apple.com/in/app/youtube-watch-listen-stream/id544007664?mt=8","https://itunes.apple.com/in/app/netflix/id363590051?mt=8","https://itunes.apple.com/in/app/apple-music/id1108187390?mt=8"]
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return img.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cel = otherapps.dequeueReusableCell(withReuseIdentifier: "cel", for: indexPath) as! apps
        let scale: Bool = true

        
        cel.back.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cel.butt.setImage(UIImage.init(imageLiteralResourceName: img[indexPath.row]), for: .normal)
        cel.butt.imageView?.contentMode = .scaleToFill
        cel.butt.layer.cornerRadius = cel.butt.frame.size.width / 2
        cel.butt.clipsToBounds = true
        cel.back.layer.cornerRadius = cel.back.frame.size.width / 2
        cel.back.clipsToBounds = true
        cel.back.layer.masksToBounds = false
        cel.back.layer.shadowColor = UIColor.black.cgColor
        cel.back.layer.shadowOpacity = 0.2
        cel.back.layer.shadowOffset = CGSize(width: -1, height: 1)
        cel.back.layer.shadowRadius = 3
//      layer.cornerRadius = 10
        //rcel.back.layer.shadowPath = UIBezierPath(rect: cel.bounds).cgPath
        cel.back.layer.shouldRasterize = true
        cel.back.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        cel.butt.tag = indexPath.row

        return cel
    }
    
    
    //MARK:Variables
    let userId = UserDefaults.standard.string(forKey: "Username")
    var password = UserDefaults.standard.string(forKey: "password")

    //MARK:IBOutlets
    @IBAction func appbutt(_ sender: Any) {
        
        //print("entered")
        let link = applinks[(sender as AnyObject).tag]
        
        let url = NSURL(string: link)!
        if UIApplication.shared.canOpenURL(url as URL) {

        
        UIApplication.shared.openURL(url as URL)
        }
        else
        {

            let link = storelinks[(sender as AnyObject).tag]
            
            let url = NSURL(string: link)!
            if UIApplication.shared.canOpenURL(url as URL) {
                
                
                UIApplication.shared.openURL(url as URL)
            
            
            //print("no whatsapp")
        }
        
    }
    }
    @IBOutlet weak var connectionStatus: UILabel!
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var ssid: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var BV: UIVisualEffectView!
    @IBOutlet weak var toggleView: UIView!
    @IBOutlet weak var wifiSelected: UIButton!
    
    
    @IBOutlet weak var viewChangeTog: UIView!
    @IBOutlet weak var popstat: UILabel!
    @IBOutlet weak var pop: card!
    
    @IBOutlet weak var act: UIActivityIndicatorView!
    
    @IBOutlet weak var otherapps: UICollectionView!
    
    
    var orgY:CGFloat!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(password)
        
        if #available(iOS 12.0, *) {
            if(traitCollection.userInterfaceStyle == .dark)
            {
                view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                otherapps.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            outerappscontainer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }
            else
            {
                view.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
                otherapps.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
                outerappscontainer.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
            }
        }
        else {
            //no dark mode available before iOS 12.0
            
            // Fallback on earlier versions
        }
        
        otherapps.delegate = self
        otherapps.dataSource = self
        
        BV.layer.opacity = 0
        //print(UserDefaults.standard.string(forKey: "regdone") as Any)
        let ssidName = Network.shared.getWiFiSsid() ?? "none"
        //print(ssidName)
        ssid.text = ssidName
        segmentControl.selectedSegmentIndex = 0
        buttonSetup()
        orgY = pop.frame.origin.y

       print(flag)
        let WifiImage = UIImage(named: "WifiSegment")?.withRenderingMode(.alwaysTemplate)
        wifiSelected.setImage(WifiImage, for: .normal)
        wifiSelected.tintColor = UIColor(red: 0.0, green: CGFloat(122.0/255.0), blue: 1.0, alpha: 1.0)
    }
    
    override func viewDidLayoutSubviews() {
        toggleView.layer.cornerRadius = 15
        toggleView.layer.shadowColor = UIColor.black.cgColor
        toggleView.layer.shadowRadius = 2.0
        toggleView.layer.shadowOffset = CGSize(width: 1, height: 1)
        toggleView.layer.shadowOpacity = 0.15
        toggleView.layer.masksToBounds = false

    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        if(flag == 1)
        {
        UIView.animate(withDuration: 0.15) {
            self.otherapps.layer.opacity = 1
        }
        }
    }
    
    //MARK:IBActions
//     @IBAction func unwindToHome(segue: UIStoryboardSegue) {}
    
    
    fileprivate func login() {
        //            Request.shared.connectionChecker { (stats) in
        //                if stats == "intvit"{
        //                    flag = 1
        //                    self.stateLabel.text = "T A P   T O   L O G O U T"
        //                    self.logButton.setImage(UIImage(named: "WifiButton ON"), for: .normal)
        //                    self.connectionStatus.text = "Logged In"
        //
        //                }
        //                else if(stats == "nointvit"){
        
        
        Request.shared.LoginApi(userId: self.userId! , password: self.password!, mode: 0) { (code) in
            //print(code)
            print("THE \(code)")
            
            //{
            if(code == 1 || code == 3)
            {
                flag = 1
                self.connectionStatus.text = "C o n n e c t e d"
                //                            self.logButton.setTitle("log out", for: .normal)
                self.logButton.setImage(UIImage(named: "WifiButton ON"), for: .normal)
                self.stateLabel.text = "T A P   T O   L O G O U T"
                
                //                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0), execute: {
                // Put your code which should be executed with a delay here
                //                                Request.shared.checkCurrentUsage(usage: { (code) in
                
                //print("usage\(code)")
                UIView.animate(withDuration: 0.2) {
                    self.act.stopAnimating()
                    self.pop.frame.origin = CGPoint(x: 0, y: self.orgY)
                    self.otherapps.layer.opacity = 1
                    
                    self.BV.layer.opacity = 0
                }
                //                                })
                //                            })
                
                
                //                                })
                //                        }
            }
                
            else if(code == 0)
            {
                
//                reset = 1
                UIView.animate(withDuration: 0.2, animations: {
                    self.act.stopAnimating()
                    self.pop.frame.origin = CGPoint(x: 0, y: self.orgY)
                    self.BV.layer.opacity = 0
                }, completion: { (true) in
                    
                    self.updatealert(title: "Error", message: "If the password hasn't been changed by you, ensure that you are logged out of all other devices & try again.")
                })
                
                
            }
            else if(code == 2)
            {
                //                        self.createalert(title: "Error", message: "Please connect to a VIT Wi-Fi network.")
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.act.stopAnimating()
                    self.pop.frame.origin = CGPoint(x: 0, y: self.orgY)
                    self.BV.layer.opacity = 0
                }, completion: { (true) in
                    self.createalert(title: "Error", message: "Please connect to a VIT Wi-Fi network. Wait for the WiFi symbol to appear on the status bar. Retry if connected.")
                    
                })
                
                
            }
        }
    }
    
    @IBAction func TestLogin(_ sender: UIButton) {
        URLCache.shared.removeAllCachedResponses()
        print("crash\(flag)")
        if flag == 1{
            
            
            UIView.animate(withDuration: 0.2, animations: {
                self.BV.layer.opacity = 0.5
                self.act.startAnimating()
                self.popstat.text = "D I S C O N N E C T I N G"
                self.pop.frame.origin = CGPoint(x: 0, y: self.orgY-self.pop.frame.height)
            }) { (true) in
                
            
            Request.shared.LogoutApi { (val) in
//                print(val)
                
                if(stat == 200)
                {
                flag = 0
                self.connectionStatus.text = "N o t  C o n n e c t e d"
                self.logButton.setTitle("log in", for: .normal)
                self.logButton.setImage(UIImage(named: "Wifi button off"), for: .normal)
                self.stateLabel.text = "T A P   T O   L O G I N"
                    
                    UIView.animate(withDuration: 0.2) {
                        self.act.stopAnimating()
                        self.pop.frame.origin = CGPoint(x: 0, y: self.orgY)
                        self.otherapps.layer.opacity = 0
                        self.BV.layer.opacity = 0
                    }
                }
                else
                {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.act.stopAnimating()
                        self.pop.frame.origin = CGPoint(x: 0, y: self.orgY)
                        self.BV.layer.opacity = 0
                    }, completion: { (true) in
                        self.createalert(title: "Error", message: "Please connect to a VIT Wi-Fi network. Wait for the WiFi symbol to appear on the status bar. Retry if connected.")
                        
                    })
                    
                    //print("FAILED no network")
                }
            }
            }
        }else{

                    
            UIView.animate(withDuration: 0.2, animations: {
                self.BV.layer.opacity = 0.5
                self.act.startAnimating()
                self.popstat.text = "C O N N E C T I N G"
                self.pop.frame.origin = CGPoint(x: 0, y: self.orgY-self.pop.frame.height)
            }) { (true) in

                self.login()

//                    Request.shared.LoginApi(userId: self.userId!, password: self.password!, mode: 1) { (val) in
//                        print("hello\(val)")
//                        if(val == 200)
//                        {
//
//                            flag = 1
//                            self.connectionStatus.text = "C o n n e c t e d"
////                            self.logButton.setTitle("log out", for: .normal)
//                            self.logButton.setImage(UIImage(named: "WifiButton ON"), for: .normal)
//                            self.stateLabel.text = "T A P   T O   L O G O U T"
//
////                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0), execute: {
//                                // Put your code which should be executed with a delay here
////                                Request.shared.checkCurrentUsage(usage: { (code) in
//
//                                    //print("usage\(code)")
//                                    UIView.animate(withDuration: 0.2) {
//                                        self.act.stopAnimating()
//                                        self.pop.frame.origin = CGPoint(x: 0, y: self.orgY)
//                                        self.otherapps.layer.opacity = 1
//
//                                        self.BV.layer.opacity = 0
//                                    }
////                                })
////                            })
//
//                        }
//                        else
//                        {
//                            UIView.animate(withDuration: 0.2, animations: {
//                                self.act.stopAnimating()
//                                self.pop.frame.origin = CGPoint(x: 0, y: self.orgY)
//                                self.BV.layer.opacity = 0
//                            }, completion: { (true) in
//                                self.createalert(title: "Error", message: "Please connect to VIT Wi-Fi.")
//
//                            })
//
//                        }
//                    } ////////////////////////////
                //////////////////
                ////////
                
                
                
                    
            }
                    
                    
//                }
//            }

        }
    }
    
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
          break
        case 1:
            performSegue(withIdentifier: "tosettings", sender: nil)
            print("seg")
             segmentControl.selectedSegmentIndex = 0
        default:
            break
        }
    }
    
    @IBAction func re(_ sender: Any) {
        
//        Request.shared.LogoutApi { (_) in
//            Request.shared.LoginApi(userId: UserDefaults.standard.string(forKey: "Username")!, password: UserDefaults.standard.string(forKey: "password")!, mode: 1) { (code) in
//                if code == 200{
//                    flag = 1
//                    self.buttonSetup()
//                    UIView.animate(withDuration: 0.2, animations: {
//                        self.BV.layer.opacity = 0
//                        self.tv.isUserInteractionEnabled = true
//                    })
//                }
//            }
//        }
    }
    
    
    func createalert(title:String, message:String)
    {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.actionSheet)
        
        
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        }))
        

        
        self.present(alert, animated: true, completion: nil)
    }
    
    func updatealert(title:String, message:String)
    {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.alert)
        
        
        
        alert.addAction(UIAlertAction(title: "U P D A T E", style: UIAlertActionStyle.default, handler: { (action) in
            
            let field1 = alert.textFields![0] as UITextField
//            print(field.text!)

            if(field1.text! == "")
            {
            
print("ended")
                self.present(alert, animated: true, completion: nil)

        
            }
            else if(field1.text! != "")
            {
                UserDefaults.standard.set(field1.text!, forKey: "password")
                self.password = field1.text!
//                print(self.password)
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.BV.layer.opacity = 0.5
                    self.act.startAnimating()
                    self.popstat.text = "C O N N E C T I N G"
                    self.pop.frame.origin = CGPoint(x: 0, y: self.orgY-self.pop.frame.height)
                })
                self.login()
                
                           alert.dismiss(animated: true, completion: nil)
            }
            }))
        
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            textField.returnKeyType = UIReturnKeyType.done
            textField.textAlignment = .center
        })
        
        alert.addAction(UIAlertAction(title: "T R Y  A G A I N", style: UIAlertActionStyle.destructive, handler: { (action) in
            
            UIView.animate(withDuration: 0.2, animations: {
                self.BV.layer.opacity = 0.5
                self.act.startAnimating()
                self.popstat.text = "C O N N E C T I N G"
                self.pop.frame.origin = CGPoint(x: 0, y: self.orgY-self.pop.frame.height)
            })
            
            self.login()
            alert.dismiss(animated: true, completion: nil)

        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:Functions
    fileprivate func buttonSetup() {
        if flag == 0{
            self.stateLabel.text = "T A P   T O   L O G I N"
            self.logButton.setImage(UIImage(named: "Wifi button off"), for: .normal)
            self.connectionStatus.text = "N o t  C o n n e c t e d"
        }else{
            
            
            self.stateLabel.text = "T A P   T O   L O G O U T"
            self.logButton.setImage(UIImage(named: "WifiButton ON"), for: .normal)
            self.connectionStatus.text = "C o n n e c t e d"
        }
    }
//    fileprivate func checkOtherDevice() {
//        Request.shared.checkCurrentUsage { (usage) in
//            print(usage)
//            if usage == "OTHER DEVICE"{
//                UIView.animate(withDuration: 0.2, animations: {
//
//                    self.BV.layer.opacity = 1
//                    self.tv.isUserInteractionEnabled = true
//                })
//            }
//
//        }
//    }
    
    @IBAction func unwindtomain(_segue:UIStoryboardSegue)
    {
        if #available(iOS 12.0, *) {
            if(traitCollection.userInterfaceStyle == .dark)
            {
                view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                otherapps.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                outerappscontainer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }
            else
            {
                view.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
                otherapps.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
                outerappscontainer.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
            }
        }
        else {
            //no dark mode available before iOS 12.0
            
            // Fallback on earlier versions
        }
    }
    
    @IBAction func gotosettings(_ sender: Any) {
        
        performSegue(withIdentifier: "tosettings", sender: nil)
        print("seg")
        segmentControl.selectedSegmentIndex = 0
    
    }
    
    
}
