//
//  HistoryTableViewCell.swift
//  ConversionCalculator
//
//  Created by Josh Chua on 10/30/19.
//  Copyright © 2019 Hamilton, Robert. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var conversionLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
