//
//  TableViewCell.swift
//  Tap
//
//  Created by Philip George on 01/09/18.
//  Copyright © 2018 Sarvad shetty. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var txt2: UITextView!
    @IBOutlet weak var txt1: UITextView!
    @IBOutlet weak var img2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
