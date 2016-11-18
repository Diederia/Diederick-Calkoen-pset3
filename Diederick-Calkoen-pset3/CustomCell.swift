//
//  CustomCell.swift
//  Diederick-Calkoen-pset3
//
//  Created by Diederick Calkoen on 14/11/16.
//  Copyright © 2016 Diederick Calkoen. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var movieBanner: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
