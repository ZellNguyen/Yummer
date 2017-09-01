//
//  FeedTableCell.swift
//  Yummer
//
//  Created by Hoa Nguyen on 2017-06-26.
//  Copyright © 2017 Hoa Nguyen. All rights reserved.
//

import UIKit

class FeedTableCell: UITableViewCell {
    @IBOutlet var friendName: UILabel!
    @IBOutlet var pickedItems: UILabel!
    @IBOutlet var lastActive: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
