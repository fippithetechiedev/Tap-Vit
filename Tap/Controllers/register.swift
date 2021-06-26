//
//  register.swift
//  Tap
//
//  Created by Philip George on 25/08/18.
//  Copyright © 2018 Sarvad shetty. All rights reserved.
//

import UIKit

class register: UIViewController {

    @IBOutlet weak var regno: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    
    
    @IBAction func regnodone(_ sender: Any) {
        regno.resignFirstResponder()
        password.becomeFirstResponder()
    }
    
    @IBAction func passdone(_ sender: Any) {
        password.resignFirstResponder()
    }
    
    @IBAction func loginpressed(_ sender: Any) {
    
        check()
    }
    
    func check()
    {
        if(regno.text == "" || password.text == "")
        {
            createalert(title: "Error", message: "Please fill in all fields.")
        }
        else if(regno.text != "" && password.text != "")
        {
            UserDefaults.standard.set(regno.text, forKey: "Username")
        UserDefaults.standard.set(password.text, forKey: "password")
            performSegue(withIdentifier: "registertomain", sender: self)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        regno.autocorrectionType = .no
        password.autocorrectionType = .no
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 */

    func createalert(title:String, message:String)
    {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.alert)
        
        
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
