//
//  reachability.swift
//  taptest
//
//  Created by Philip George on 25/08/18.
//  Copyright © 2018 Philip George. All rights reserved.
//


import Foundation
import SystemConfiguration.CaptiveNetwork

class Network{
    static let shared:Network = Network()
    
    //to get ssid of network
    func getWiFiSsid() -> String? {
        var ssid: String?
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    break
                }
            }
        }
        return ssid
    }

}


