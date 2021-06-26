//
//  lastob.swift
//  Tap
//
//  Created by Philip George on 12/09/18.
//  Copyright © 2018 Sarvad shetty. All rights reserved.
//

import UIKit

class lastob: UIViewController {

    @IBAction func press(_ sender: Any) {
    
    UserDefaults.standard.set("done", forKey: "onBoard")

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

}
