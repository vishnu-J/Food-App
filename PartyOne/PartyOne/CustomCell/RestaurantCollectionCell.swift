//
//  RestaurantsCell.swift
//  PartyOne
//
//  Created by Vishnu on 26/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit

class RestaurantCollectionCell: UITableViewCell {

    @IBAction func backBtnAction(_ sender: UIButton) {
    }
    /*@IBOutlet weak var addItembtn: UIButton!
    @IBOutlet weak var countlbl: UILabel!
    @IBOutlet weak var decrementbtn: UIButton!*/
    
    @IBOutlet weak var res_descriptionlbl: UILabel!
    @IBOutlet weak var res_imgView: UIImageView!
    @IBOutlet weak var res_namelbl: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    /*@IBAction func decrementbtnAction(_ sender: UIButton) {
        if count > 0{
            count -= 1
        }
        
    }
    @IBAction func incrementbtnAction(_ sender: UIButton) {
        count += 1
        countlbl.text = "\(count)"
    }*/
}
