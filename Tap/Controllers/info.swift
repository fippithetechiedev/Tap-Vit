//
//  info.swift
//  Tap
//
//  Created by Philip George on 01/09/18.
//  Copyright © 2018 Sarvad shetty. All rights reserved.
//

import UIKit

class info: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {
   
    var link = ""
    var date = ""
    
    @IBOutlet weak var regbut: UIButton!
    @IBOutlet weak var disbut: UIButton!
    @IBOutlet weak var tv: UITextView!
    @IBOutlet weak var iv: UIImageView!
    
    @IBOutlet weak var bv: UIVisualEffectView!
    
    @IBOutlet weak var titl: UILabel!
    
    @IBAction func reg(_ sender: Any) {
        

        let urlString = link
        
        
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    @IBAction func back(_ sender: Any) {
        performSegue(withIdentifier: "info2settings", sender: self)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.bv.layer.opacity = 0
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let coll = col.dequeueReusableCell(withReuseIdentifier: "coll", for: indexPath) as! CollectionViewCell
        
        coll.img.layer.cornerRadius = 5

        coll.mo.tag = indexPath.row
        
        
        coll.img.image = UIImage.init(imageLiteralResourceName: viewimg[indexPath.row])
        coll.lab.text = events[indexPath.row]
        
        return coll
        
        
        
        
        
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
    
    
    @IBAction func more(_ sender: Any) {
       
        
        if((sender as AnyObject).tag == 0)
        {
            

            iv.image = #imageLiteral(resourceName: "ios")
            tv.text = "The start of every great creation originates from an idea and behind every great idea lies an even greater problem. Always pondered over manifesting that very same idea into an app?Wait no more! Here is your best chance to build your best solution to that greater problem. Come and join us for iOS Fusion this September! \n\nwww.adgvit.com/ios"
            
            link = "http://www.vit.ac.in/files/gravitas18/events.html"
            date = "14.09.18"
            titl.text = events[0]
            

            
        }
        else if((sender as AnyObject).tag == 1)
        {
            iv.image = #imageLiteral(resourceName: "uni")
            tv.text = "Augmented reality has impacted every sphere of life. It's time to broaden your imagination and explore a completely new space of creativity. As said by Wayne Dyer “If you change the way you look at things, the things you look at change.” \nADG hence brings up this opportunity for everyone (with or without any technical knowledge) to participate and experience something which would help you interleave the virtual world with the real world. Looking forward to having an amazing learning experience. See you there!"
                link = "http://www.vit.ac.in/files/gravitas18/events.html"
            date = "30.09.18"
                        titl.text = events[1]

            
        }
        else if((sender as AnyObject).tag == 2)
        {
            
            iv.image = #imageLiteral(resourceName: "app")
            tv.text = "Come & build amazing apps. Amazing prizes & goodies up for grabs!"
            date = ""
                        titl.text = events[2]

                        link = ""

        }
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "R E G I S T E R")
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))


    if(link == "")
    {

        regbut.isUserInteractionEnabled = false
        regbut.setAttributedTitle(attributeString, for: .normal)
    }
    else
    {
        regbut.isUserInteractionEnabled = true
 regbut.setAttributedTitle(NSMutableAttributedString(string: "R E G I S T E R"), for: .normal)
    }
        
        
        UIView.animate(withDuration: 0.2) {
            self.bv.layer.opacity = 1
        }
    
    
    }
    
    
    
    @IBOutlet weak var col: UICollectionView!
    
    var names = ["PHILIP GEORGE\nDEVELOPER","PRANAV KARNANI\nDEVELOPER","ARITRO PAUL\nDESIGNER","SARVAD SHETTY\nDEVELOPER", "TUSHAR SINGH\nDESIGNER"]
    var images = ["p","pranav","aritro","s","t"]
    var events = ["iOS Fusion","Unidev","App-A-Thon"]
    
    var viewimg = ["ios","uni","app"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tab.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        if #available(iOS 12.0, *) {
            if(traitCollection.userInterfaceStyle == .dark)
            {
                cell.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                cell.txt1.textColor = UIColor.red
                

            }
            else
            {
                cell.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
                cell.txt1.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.txt2.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
        else {
            //no dark mode available before iOS 12.0
            
            // Fallback on earlier versions
        }

        
        cell.img1.layer.cornerRadius = 10
        cell.img1.clipsToBounds = true
        cell.img2.clipsToBounds = true
        cell.img2.layer.cornerRadius = 10
        cell.img1.layer.borderWidth = 1
        cell.img2.layer.borderWidth = 1
        cell.img1.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.img2.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        var n = ""
        
        
        if(names[indexPath.row].contains("PROJECT LEAD"))
        {
            n="PROJECT LEAD"
        }
        else if(names[indexPath.row].contains("DEVELOPER"))
        {
            n="DEVELOPER"
        }
        else if(names[indexPath.row].contains("DESIGNER"))
        {
            n="DESIGNER"
        }
        
        
        
        if(indexPath.row%2 == 0)
        {
        cell.img1.image = UIImage.init(imageLiteralResourceName: images[indexPath.row])
            cell.txt1.text = names[indexPath.row]


            if n != ""
            {
            cell.txt1.halfTextColorChange(fullText: cell.txt1.text! , changeText: n )
            }
            
            
        cell.img2.isHidden = true
        cell.txt2.isHidden = true
        cell.img1.isHidden = false
        cell.txt1.isHidden = false
        }
        else
            
        {
            cell.img2.image = UIImage.init(imageLiteralResourceName: images[indexPath.row])
            cell.txt2.text = names[indexPath.row]
         

            if n != ""
            {
                cell.txt2.halfTextColorChange(fullText: cell.txt2.text! , changeText: n)

            }
            
            cell.img1.isHidden = true
            cell.txt1.isHidden = true
            cell.img2.isHidden = false
            cell.txt2.isHidden = false
            
        }
        
//        cell.img1.image = UIImage.init(imageLiteralResourceName: "f")
//        cell.img2.image = UIImage.init(imageLiteralResourceName: "ADGLogo")
//        cell.txt1.text = "Philip George"
//        cell.txt2.text = "Sarvad Shetty"
        
        return cell
        
        
    }
    

    @IBOutlet weak var tab: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 12.0, *) {
            if(traitCollection.userInterfaceStyle == .dark)
            {
                view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                col.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                tab.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                tv.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }
            else
            {
                view.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
                col.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
                tab.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
                
                
            }
        }
        else {
            //no dark mode available before iOS 12.0
            
            // Fallback on earlier versions
        }
        tab.delegate = self
        tab.dataSource = self
        col.delegate = self
        col.dataSource = self
        
        bv.layer.opacity = 0
        regbut.layer.cornerRadius = 10
        disbut.layer.cornerRadius = 10
        col.scrollsToTop = true

        
        
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
extension UITextView {
    func halfTextColorChange (fullText : String , changeText : String ) {
        let strNumber: NSString = fullText as NSString
        let fullrange = strNumber.range(of: fullText)
        let range = strNumber.range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: #colorLiteral(red: 0.08235294118, green: 0.4745098039, blue: 0.9647058824, alpha: 1) , range: range)
        attribute.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 8, weight: .semibold), range: fullrange)
        attribute.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 9, weight: .medium), range: range)
        self.attributedText = attribute
    }
}
