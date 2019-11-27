//
//  RestaurantViewController.swift
//  PartyOne
//
//  Created by Vishnu on 27/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {
 
    var restaurantObj : Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var RestaurantImgView: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var descriptionlbl: UILabel!
    @IBOutlet weak var cuisinelbl: UILabel!
    
    @IBOutlet weak var reviewCountlbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var rating: FloatRatingView!
    

    @IBAction func backbtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
