//
//  MMOverviewCell.swift
//  MyMovie
//
//  Created by Gustavo Luís Soré on 04/09/17.
//  Copyright © 2017 Gustavo Luís Soré. All rights reserved.
//

import UIKit

class MMOverviewCell: UITableViewCell {
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
