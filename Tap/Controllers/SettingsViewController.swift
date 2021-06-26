//
//  SettingsViewController.swift
//  Tap
//
//  Created by Sarvad shetty on 8/25/18.
//  Copyright © 2018 Sarvad shetty. All rights reserved.
//
import UIKit

var datadone = 0
var req = 0

class SettingsViewController: UIViewController {
    
    
    //MARK:IBOutlets
    @IBOutlet weak var toggleView: UIView!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var userLoggedIn: UILabel!
    @IBOutlet weak var dataUsage: UILabel!
    @IBOutlet weak var autoLoginState: UISwitch!
    //setting button properties
    @IBOutlet weak var changePasswordButtonOutlet: UIButton!
    @IBOutlet weak var autoLoginButtonOutlet: UILabel!
    @IBOutlet weak var logoutButtonOutlet: UIButton!
    //current view
    @IBOutlet weak var settingButtonView: UIButton!
    
    @IBOutlet weak var act: UIActivityIndicatorView!
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        URLCache.shared.removeAllCachedResponses()

        print(datadone)
        if(datadone == 0 || dataUsage.text == "-")
        {
            
        
        Request.shared.connectionChecker { (a) in
            print(a)
        
            
            if(a=="intvit")
            {

                if(self.dataUsage.text == "-")
                {
                    self.act.layer.opacity = 1
                    self.act.startAnimating()
                    
                }
                
        Request.shared.checkCurrentUsage { (b) in
           
            self.act.stopAnimating()
            self.act.layer.opacity = 0
            if(b == "There are no records for this period")
            {
                self.dataUsage.text = "0.00 MB"
            }
            else
            {
                
            self.dataUsage.text = b 
            }
//                print(b)
            URLCache.shared.removeAllCachedResponses()

            
        }
                URLCache.shared.removeAllCachedResponses()

            
                datadone = 1
            }
        
            }
            
        }
        URLCache.shared.removeAllCachedResponses()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "autoLogin") == false{
            autoLoginState.isOn = false
        }else{
            autoLoginState.isOn = true
        }
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
        
        act.layer.opacity = 0
        
        // Do any additional setup after loading the view.
        segmentControl.selectedSegmentIndex = 1
//        if flag == 1{
//            userLoggedIn.text = UserDefaults.standard.string(forKey: "Username")
////            Request.shared.checkCurrentUsage { (usage) in
////                self.dataUsage.text = usage
////            }
//        }else{
            userLoggedIn.text = UserDefaults.standard.string(forKey: "Username")
            dataUsage.text = UserDefaults.standard.string(forKey: "dataUsage")
//        }
        let SegmentImage = UIImage(named: "SettingsSegment")?.withRenderingMode(.alwaysTemplate)
        settingButtonView.setImage(SegmentImage, for: .normal)
//        SettingsButton.tintColor = UIColor(red: 0.0, green: CGFloat(122.0/255.0), blue: 1.0, alpha: 1.0)
        settingButtonView.tintColor = UIColor(red: 0.0, green: CGFloat(122.0/255.0), blue: 1.0, alpha: 1.0)
        
    }
    
    override func viewDidLayoutSubviews() {
        toggleView.layer.cornerRadius = 15
        toggleView.layer.shadowColor = UIColor.black.cgColor
        toggleView.layer.shadowRadius = 2.0
        toggleView.layer.shadowOffset = CGSize(width: 1, height: 1)
        toggleView.layer.shadowOpacity = 0.15
        toggleView.layer.masksToBounds = false
        
        changePasswordButtonOutlet.layer.masksToBounds = true
        changePasswordButtonOutlet.clipsToBounds = true
        changePasswordButtonOutlet.layer.cornerRadius = 15
        
        autoLoginButtonOutlet.layer.masksToBounds = true
        autoLoginButtonOutlet.clipsToBounds = true
        autoLoginButtonOutlet.layer.cornerRadius = 15
        
        logoutButtonOutlet.layer.masksToBounds = true
        logoutButtonOutlet.clipsToBounds = true
        logoutButtonOutlet.layer.cornerRadius = 15
    }
    
    //MARK:IBActions
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            performSegue(withIdentifier: "unwind2main", sender: self)
            segmentControl.selectedSegmentIndex = 1
            break
        case 1:
            break
            
        default:
            break
        }
    }
    @IBAction func autoLoginStateSwitcher(_ sender: UISwitch) {
        if autoLoginState.isOn{
            UserDefaults.standard.set(true, forKey: "autoLogin")
        }else{
            UserDefaults.standard.set(false, forKey: "autoLogin")
        }
    }
    @IBAction func goBack(_ sender: Any) {
        performSegue(withIdentifier: "unwind2main", sender: self)
    }
    
    @IBAction func LogoutPressed(_ sender: UIButton) {
        URLCache.shared.removeAllCachedResponses()

        logout.isUserInteractionEnabled = false
        logout.setTitle("         W A I T", for: .normal)
        
        Request.shared.LogoutApi { (response) in

            print(stat)
            if(stat == 200)
            {
                UserDefaults.standard.removeObject(forKey: "Username")
                UserDefaults.standard.removeObject(forKey: "password")
                UserDefaults.standard.removeObject(forKey: "dataUsage")
                UserDefaults.standard.removeObject(forKey: "autoLogin")
                UserDefaults.standard.removeObject(forKey: "linkHref")

                
                datadone = 0
                req = 1
                
                URLCache.shared.removeAllCachedResponses()

                
            self.performSegue(withIdentifier: "delete", sender: self)
            }
            else
            {
                //connection alert
                self.createalert(title: "Error", message: "Please connect to a VIT Wi-Fi network.")
                self.logout.isUserInteractionEnabled = true
                self.logout.setTitle("         R E M O V E  A C C O U N T", for: .normal)
                URLCache.shared.removeAllCachedResponses()

            }
        }

    
    }
    
    
    func createalert(title:String, message:String)
    {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.actionSheet)
        
        
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func addCardPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "addCard", sender: nil)
    }
    
    @IBAction func unwindtosettings(_segue:UIStoryboardSegue)
    {
        
        
    }
}
