//
//  RestaurantCell.swift
//  Zomato
//
//  Created by Vishnu on 25/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var restaurantImg: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var restaurnatDescription: UILabel!
    @IBOutlet weak var ratinglbl: UILabel!
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var cuisine_txt: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var rating_txt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
