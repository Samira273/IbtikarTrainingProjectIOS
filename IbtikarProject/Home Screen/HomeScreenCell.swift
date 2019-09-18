//
//  HomeScreenCell.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/17/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import UIKit

class HomeScreenCell: UITableViewCell  {

    @IBOutlet weak  var cellLabel: UILabel!
    @IBOutlet weak  var cellImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
}
