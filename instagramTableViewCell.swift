//
//  instagramTableViewCell.swift
//  Instagram
//
//  Created by Nathan Miranda on 1/28/16.
//  Copyright © 2016 Miraen. All rights reserved.
//

import UIKit

class instagramTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var instagramImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
