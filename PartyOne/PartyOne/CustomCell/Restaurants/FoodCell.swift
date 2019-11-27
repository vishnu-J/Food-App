//
//  RestaurantsCell.swift
//  PartyOne
//
//  Created by Vishnu on 26/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit

class FoodCell: UITableViewCell {

    @IBOutlet weak var addItembtn: UIButton!
    @IBOutlet weak var countlbl: UILabel!
    @IBOutlet weak var decrementbtn: UIButton!
    
    var count = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func decrementbtnAction(_ sender: UIButton) {
        if count > 0{
            count -= 1
            countlbl.text = "\(count)"
        }
        
    }
    @IBAction func incrementbtnAction(_ sender: UIButton) {
        count += 1
        countlbl.text = "\(count)"
    }
}
