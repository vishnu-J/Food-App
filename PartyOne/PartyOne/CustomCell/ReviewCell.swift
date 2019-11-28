//
//  ReviewCell.swift
//  PartyOne
//
//  Created by Vishnu on 28/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {

    
    @IBOutlet weak var reviewerImageView: UIImageView!
    @IBOutlet weak var reviewerName: UILabel!

    @IBOutlet weak var ratinglbl: UILabel!
    @IBOutlet weak var ratingView: UIView!
    
    @IBOutlet weak var reviewCountlbl: UILabel!
    @IBOutlet weak var reviewtimelbl: UILabel!
    @IBOutlet weak var ratingtxtlbl: UILabel!
    @IBOutlet weak var commentCountlbl: UILabel!
    @IBOutlet weak var reviewlbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
