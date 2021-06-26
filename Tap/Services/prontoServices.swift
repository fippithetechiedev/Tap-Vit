//
//  prontoServices.swift
//  Tap
//
//  Created by Sarvad shetty on 8/23/18.
//  Copyright © 2018 Sarvad shetty. All rights reserved.
//

import Foundation
import Alamofire
import SwiftSoup

//flag2 for login
var stat = 0
var status = ""

//var def : Array<Element> = [<b></b>]
class Request{
    //a shared variable
    static var shared:Request = Request()

    
    //MARK:Variables
    let FirstLoginApiUrl:String = "http://www.google.com"
    let LoginApiUrl:String = "http://phc.prontonetworks.com/cgi-bin/authlogin"
    let logoutApiUrl:String = "http://phc.prontonetworks.com/cgi-bin/authlogout"
    let offlineCardApiUrl1:String = "http://136.233.9.110/registration/main.do?content_key=%2FOfflinePrepaidCards.jsp"
    let offlineCardApiUrl2:String = "http://136.233.9.110/registration/AddOfflinePrepaidCards.do"
    let changePassLink1:String = "http://136.233.9.110/registration/main.do?content_key=%2FChangePassword.jsp"
    let changePassLink2:String = "http://136.233.9.110/registration/changePassword.do"
    var linkHref:String = ""
    var usage:String = ""
    var login = ""
    var templink = ""
    
    //MARK:Functions
    func LoginApi(userId:String,password:String,mode:Int,result: @escaping(_ statusCode:Int)->Void){
        //stat = 0
//        UserDefaults.standard.set(1, forKey: "flag2")
        
        //Storing user details into NSUserDefaults
//        let userDefaults = UserDefaults.standard
//        userDefaults.set(userId, forKey: "userId")
//        userDefaults.set(password, forKey: "password")
        

        //service name and submit22 for parameters
        let serviceName:String = "ProntoAuthentication"
        let Submit22:String = "Login"
        
        //parameters
        let parameters = ["userId":userId,"password":password,"serviceName":serviceName,"Submit22":Submit22]
        
        URLCache.shared.removeAllCachedResponses()
        //Networking part
        Alamofire.request(LoginApiUrl, method: .post, parameters: parameters).response { (response) in
            
            
            //stat = response.response?.statusCode ?? 0
            //print("STATUSlogin \(stat)")

            if(mode == 1)
            {
                print("danger zone")
                //print(response.response?.statusCode)
            if response.response?.statusCode == 200{
                result((response.response?.statusCode)!)
                let data = response.data
                let utf8txt = String(data: data!,encoding: .utf8)
                //print(utf8txt!)
                
                    do{
                        guard let html = utf8txt else{return}
                        let doc: Document = try SwiftSoup.parse(html)
                        
                        if(html.contains("New Document"))
                        {
                            print("fucked")
                            result(4) //account expired
                        }
                        
                        else
                        {
                        let link: Element = try doc.select("a").first()!
                        self.linkHref = try link.attr("href")
                        
                        UserDefaults.standard.set(self.linkHref, forKey: "linkHref")
                        }//print(UserDefaults.standard.string(forKey: "linkHref"))
                    }catch{}
                flag = 1
            }
            else
            {result(2)}
        }
            else if(mode == 0)
            {
                
                if response.response?.statusCode == 200{
                //result((response.response?.statusCode)!)
                let data = response.data
                let utf8txt = String(data: data!,encoding: .utf8)
                //print(utf8txt!)
                
                do{
                    guard let html = utf8txt else{return}
                    let doc: Document = try SwiftSoup.parse(html)
                    print(doc)
//                    print(html.contains("Internal Error"))
                    
                    if(html.contains("New Document"))
                    {
                        print("fucked")
                        result(4) //account expired
                    }
                    else if(html.contains("Internal Error"))
                    {
                        result(2)
                    }
                    else if(html.contains("You are already logged in"))
                    {
                        result(3)
                    }
                    else
                    {
                    
                    let link = try? doc.select("a").first()!
                    let el = try doc.select("td").hasClass("errorText10")
                    let sta = html.contains("Try Again")
                    print(sta)
                    if(try link?.attr("href") == "http://136.233.9.110/registration/customization/1/ChooseAuthOfflineRec.jsp?wispId=1&orgUrl=&dynMacAuth=&hidWispId=1" || el == true || sta == true)
                    {
                     result(0)
                    }
                    else
                    {
                        result(1)
//                        userDefaults.set(userId, forKey: "userId")
//                        userDefaults.set(password, forKey: "password")
                        UserDefaults.standard.set(try link?.attr("href"), forKey: "linkHref")
                    }
                    
                    //print(link)
                    //                    self.linkHref = try link.;
                    //                    UserDefaults.standard.set(self.linkHref, forKey: "linkHref")
                    //                    print(UserDefaults.standard.string(forKey: "linkHref"))
                    }}
                catch{}
//                flag = 0
                
            }
                else
                {
                    print("undetermined\(String(describing: response.response?.statusCode))")
                    result(2)
                }
        }
    }
    }
    
    
    //log out function
    func LogoutApi(result:@escaping(_ statusCode:String)->Void){
        Alamofire.request(logoutApiUrl, method: .post).response { (response) in
            stat = 0
            stat = response.response?.statusCode ?? 0
            print(stat)
            print("logged out")
            result("Logged Out")
//            UserDefaults.standard.set(1, forKey: "flag2")
        }
    }
    
    
//    func checkpass(userId:String,password:String,result: @escaping(_ statusCode:Int)->Void)
//    {
//        let userDefaults = UserDefaults.standard
//        userDefaults.set(userId, forKey: "userId")
//        userDefaults.set(password, forKey: "password")
//
//
//        //service name and submit22 for parameters
//        let serviceName:String = "ProntoAuthentication"
//        let Submit22:String = "Login"
//
//        //parameters
//        let parameters = ["userId":userId,"password":password,"serviceName":serviceName,"Submit22":Submit22]
//
//        //Networking part
//        Alamofire.request(LoginApiUrl, method: .post, parameters: parameters).response { (response) in
//
//            print(response.response?.statusCode ?? 0)
//
//            if response.response?.statusCode == 200{
//                result((response.response?.statusCode)!)
//                let data = response.data
//                let utf8txt = String(data: data!,encoding: .utf8)
//                //print(utf8txt!)
//
//                do{
//                    guard let html = utf8txt else{return}
//                    let doc: Document = try SwiftSoup.parse(html)
//
//                    let link = try doc.select("a").first()!
//
//
//                    print(link)
//
//
//
//                    //                    self.linkHref = try link.;
////                    UserDefaults.standard.set(self.linkHref, forKey: "linkHref")
////                    print(UserDefaults.standard.string(forKey: "linkHref"))
//                }catch{}
//                flag = 1
//            }
//        }
//    }
    
    
    //change password
    
func changePassword(changeUserId:String,changePassword:String,changeNewPassword:String,changeConfirmNewPassword:String,result:@escaping(_ statusCode:String)->Void){
       stat = 0
        //for params1
        let submit = "Update"
        //params
        let params1 =  ["changeUserId":changeUserId,"changePassword":changePassword,"changeNewPassword":changeNewPassword,"changeConfirmNewPassword":changeConfirmNewPassword,"submit":submit]
        
        //strp by step method for adding offline cards
    
    templink = UserDefaults.standard.string(forKey: "linkHref")! //changed 29th july 2019
    var temparr = templink.components(separatedBy: "?")
    print("yolo \(temparr[1])")
    templink = "http://136.233.9.110/registration/Main.jsp?"+temparr[1] //**
    
        Alamofire.request(templink, method: .post).response { (response) in
            
            if response.response?.statusCode == 200{
                Alamofire.request(self.changePassLink1, method: .get).response(completionHandler: { (res) in
                    if res.response?.statusCode == 200{
                        Alamofire.request(self.changePassLink2, method: .post, parameters: params1).response(completionHandler: { (res2) in
                            if res2.response?.statusCode == 200{
                                let data = res2.data
                                let utf8txt = String(data: data!,encoding: .utf8)
                                print(utf8txt!)
                                if utf8txt?.contains("Password information has been updated successfully.") == true{
                                    result("Password information has been updated successfully.")
                                }else{
                                    result("Error while changing.")
                                }
                            }else{
                                result("Error while changing.")
                            }
                        })
                    }else{
                        result("Error while changing.")
                    }
                })
            }else{
                result("Error while changing.")
            }
        }
        
    }
    
    //to check current usage
    func checkCurrentUsage(usage:@escaping(String)->Void){
        stat = 0
        var data2:Data?
        
        URLCache.shared.removeAllCachedResponses()
        print("hi \(UserDefaults.standard.string(forKey: "linkHref")!)")
        templink = UserDefaults.standard.string(forKey: "linkHref")! //changed 29th july 2019
        var temparr = templink.components(separatedBy: "?")
        print("yolo \(temparr[1])")
        templink = "http://136.233.9.110/registration/Main.jsp?"+temparr[1] //**
        URLCache.shared.removeAllCachedResponses()

        Alamofire.request(templink, method: .post).response { (response) in //**
            stat = response.response?.statusCode ?? 0
            
            if stat == 200{
                data2 = response.data
                
                let utf8text2 = String(data:data2!,encoding:.utf8)
                //parsing file2
                do{
                    guard let ht = utf8text2 else{return}
                    let doc: Document = try SwiftSoup.parse(ht)

                    //print(doc)
//                    if try doc.select("b").last() != nil
//                    {
                    print(try doc.select("b").last() as Any)
                    if( try (doc.select("b").last() != nil))
                    {
                    self.usage = try (doc.select("b").last()?.text())!
                        UserDefaults.standard.set(self.usage, forKey: "dataUsage")
                        UserDefaults.init(suiteName:"group.Fippinew.TAP")?.setValue(self.usage, forKey: "widgetUsage")
                        //print(self.usage)
                        usage(self.usage)
                        
                    }
                    else
                    {
                    if let x = UserDefaults.standard.value(forKey: "dataUsage")
                        {
                            usage(x as! String)
                            //print("present")
                        }
                        else
                        {
                        
                        UserDefaults.standard.set("-", forKey: "dataUsage")
                        
                        }
                        }
//                    }
//                    else
//                    {
////                        print("OTHER DEVICE")
//                        usage("OTHER DEVICE")
//                    }
                }catch{}
            }
        }
    }
    
    func connectionChecker(connectStats:@escaping(String)->Void){
        
        //stat = 0
        //status = ""
//        //service name and submit22 for parameters
//        let serviceName:String = "ProntoAuthentication"
//        let Submit22:String = "Login"
        
        //parameters
       // let params = ["userId":UserDefaults.standard.string(forKey: "Username") ?? "","password":UserDefaults.standard.string(forKey: "password") ?? "","serviceName":serviceName,"Submit22":Submit22]
        
        Alamofire.request(FirstLoginApiUrl,method: .get).response { (response) in
            stat = response.response?.statusCode ?? 0

            print("HERE\(stat)")
           // print(String(data: response.data!,encoding: .utf8))
//                print(utf8txt!) ?? nil)
            
            if stat == 200 && String(data: response.data!,encoding: .utf8) != nil {
                //html data
                // ON VIT WIFI & NO INTERNET CONNECTION
                let data = response.data
                let utf8txt = String(data: data!,encoding: .utf8)
                //print(utf8txt!)
                
                //to find for "Already Logged in"
                do{
                    guard let html = utf8txt else{return}
                    let doc: Document = try SwiftSoup.parse(html)
                    let link: Element = try doc.select("TITLE").first()!
//                    self.login = try link.text()
//                    print(self.login)

                    //print(try link.text() ?? "nope")
                    if try link.text() == "Redirect"{
                        //print("done")
                        connectStats("nointvit")
                        status = "nointvit"
                    }
                    
//                        else{
//                        connectStats("not connected")
//                    }
                }catch{}
                
            }
            else if(stat == 200 && String(data: response.data!,encoding: .utf8) == nil )
            {
                print("entered")
                //ON VIT WIFI or DATA & INTERNET CONNECTION
                Alamofire.request(self.LoginApiUrl,method: .get).response { (res) in
                
                    stat = res.response?.statusCode ?? 0
                    print("HELLO \(stat)")
                    if(stat == 200)
                    {
                        connectStats("intvit")
                        //print("ON VIT WIFI")
                        status = "intvit"
                    }
                    else if(stat == 404)
                    {
                        connectStats("ondata")
                        status = "ondata"
                        print("ondata")
                    }
                    else
                    {
                        status = "noconnect"
                        connectStats("noconnect")
                        
                    }
                    
                
                }
                
//                connectStats("failed to connect")
                
                //print("failed to connect")
            }
            else if(stat == 0||stat==404)
            {   status = "noconnect"
                connectStats("noconnect")
            }
        }
    
    }
    

}




    
    


