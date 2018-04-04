//
//  leftMenuTableViewCell.swift
//  Ugurcan
//
//  Created by Apple on 26/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class LeftMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewType: UIImageView!

    @IBOutlet weak var lbl_Type: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
