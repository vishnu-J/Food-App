//
//  MenuCell.swift
//  PartyOne
//
//  Created by Vishnu on 29/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var menuImageView: UIImageView!
    
    @IBOutlet weak var menuNamelbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        holderView.roundCorners(corners: [.topRight, .bottomRight], radius: 20)
    }
    
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
