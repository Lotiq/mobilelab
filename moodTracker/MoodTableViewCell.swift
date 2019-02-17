//
//  MoodTableViewCell.swift
//  moodTracker
//
//  Created by Timothy on 2/16/19.
//  Copyright © 2019 Timothy. All rights reserved.
//

import UIKit

class MoodTableViewCell: UITableViewCell {

    @IBOutlet weak var moodImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
