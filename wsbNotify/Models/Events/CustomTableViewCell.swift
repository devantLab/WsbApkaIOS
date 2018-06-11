//
//  CustomTableViewCell.swift
//  WSB
//
//  Created by apple on 05.04.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventPlace: UILabel!
    @IBOutlet weak var eventMonth: UILabel!
    @IBOutlet weak var eventDay: UILabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var eventTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
