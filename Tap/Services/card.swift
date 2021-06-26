//
//  card.swift
//  Enactustrial
//
//  Created by Philip George on 14/01/18.
//  Copyright © 2018 Philip George. All rights reserved.
//

import UIKit

@IBDesignable class card: UIView {
    
    override  func layoutSubviews() {
        let scale: Bool = true
        
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 4
        layer.cornerRadius = 10
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}

