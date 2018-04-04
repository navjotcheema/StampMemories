//
//  customTableViewCell.swift
//  StampMemories
//
//  Created by Apple on 15/01/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {

    @IBOutlet weak var tf_Role: UITextField!
    
    @IBOutlet weak var tf_UserServiceType: UITextField!
    @IBOutlet weak var tf_SelectUserType: UITextField!
    @IBOutlet weak var tfCode: UITextField!
    @IBOutlet weak var tfBusinessName: UITextField!
    @IBOutlet weak var tf_FirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfLocation: UITextField!
        @IBOutlet weak var flagImageView: UIImageView!

    
    
    @IBOutlet weak var tfMobileNo: UITextField!
    
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    
    
    @IBOutlet weak var tfConfirmPassword: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
