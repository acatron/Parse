//
//  PhotoTableViewCell.swift
//  Instagram
//
//  Created by Aurielle on 3/2/16.
//  Copyright © 2016 Aurielle. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var insta_photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
