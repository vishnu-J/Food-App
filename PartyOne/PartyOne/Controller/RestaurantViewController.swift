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
    let restaurantViewModel = RestaurantViewModel()
    
    @IBOutlet weak var RestaurantImgView: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var descriptionlbl: UILabel!
    @IBOutlet weak var cuisinelbl: UILabel!
    
    @IBOutlet weak var reviewCountlbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var rating: FloatRatingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getReviews()
        ImageLib.sharedInstance().download(for: (restaurantObj?.featured_image)!, mountOver: RestaurantImgView)
        name.text = restaurantObj?.name
        rating.rating = Double((restaurantObj?.user_rating?.aggregate_rating)!)!
        cuisinelbl.text = restaurantObj?.cuisines
        
        pricelbl.text = "\((restaurantObj?.currency)!) \((restaurantObj?.average_cost_for_two)!)"
        // Do any additional setup after loading the view.
    }

    
    @IBAction func backbtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    private func getReviews(){
        restaurantViewModel.makeReviewRequest(with: (restaurantObj?.id)!) { (review, error) in
            DispatchQueue.main.async {
                self.reviewCountlbl.text = "\((review?.reviews_count)!) Reviews"
            }
        }
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
