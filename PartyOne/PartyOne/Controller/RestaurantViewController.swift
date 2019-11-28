//
//  RestaurantViewController.swift
//  PartyOne
//
//  Created by Vishnu on 27/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {
 
    @IBOutlet weak var RestaurantImgView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionlbl: UILabel!
    @IBOutlet weak var cuisinelbl: UILabel!
    @IBOutlet weak var reviewCountlbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var rating: FloatRatingView!
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    @IBOutlet weak var highlightlbl: UILabel!
    
    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var eventBlurView: UIVisualEffectView!
    @IBOutlet weak var eventsView: UIView!
    @IBOutlet weak var deliveryStatuslbl: UILabel!
    @IBOutlet weak var priceRangelbl: UILabel!
    @IBOutlet weak var votelbl: UILabel!
    @IBOutlet weak var pricerangeView: UIView!
    
    var restaurantObj : Restaurant?
    let restaurantViewModel = RestaurantViewModel()
    var reviewList : [User_reviews]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getReviews()
        registerCell()
        ImageLib.sharedInstance().download(for: (restaurantObj?.featured_image)!, mountOver: RestaurantImgView)
        name.text = restaurantObj?.name
        rating.rating = Double((restaurantObj?.user_rating?.aggregate_rating)!)!
        cuisinelbl.text = restaurantObj?.cuisines
        pricelbl.text = "\((restaurantObj?.currency)!) \((restaurantObj?.average_cost_for_two)!)"
        if let priceRange = restaurantObj?.price_range{
            priceRangelbl.text = "\(priceRange)"

            if priceRange < 3{
                pricerangeView.backgroundColor = .red
            }else if priceRange > 3{
                pricerangeView.backgroundColor = UIColor(hexString: "006400")
            }else{
                pricerangeView.backgroundColor = .orange
            }
        }
        
        if restaurantObj?.is_delivering_now == 1{
            deliveryStatuslbl.text = "Delivery Available Now"
            deliveryStatuslbl.textColor = UIColor(displayP3Red: 220/255.0, green: 20/255.0, blue: 60/255, alpha: 1)
        }else{
            deliveryStatuslbl.text = "Delivery UnAvailable"
            deliveryStatuslbl.textColor = .lightGray
        }
        
        votelbl.text = "\((restaurantObj?.user_rating?.votes!)!) \n Votes"
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            eventsView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 15)
    }
    
    @IBAction func backbtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    private func registerCell(){
        reviewCollectionView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellWithReuseIdentifier: Constants.REVIEW_IDENTIFIER)
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self
    }
    private func getReviews(){
        restaurantViewModel.makeReviewRequest(with: (restaurantObj?.id)!) { (review, error) in
            self.reviewList = review?.user_reviews
            DispatchQueue.main.async {
                if let count = review?.reviews_count{
                    self.reviewCountlbl.text = "\(count) Reviews"
                }
                self.reviewCollectionView.reloadData()
            }
        }
        
        restaurantViewModel.makeDailyMenuRequest(with: (restaurantObj?.id)!) { (menulist, error) in

        }
    }
    
    private func getHighlights(from highlights:[String]) -> String{
        var highLightStr = ""
        highlights.forEach { (highlight) in
            highLightStr.append(highlight)
        }
        return highLightStr
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.EVENT_VC_SEGUE{
            let eventVC = segue.destination as! EventsViewController
        }
    }
 
    
    


}


extension RestaurantViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let _ = reviewList{
            return (reviewList?.count)!
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.REVIEW_IDENTIFIER, for: indexPath) as! ReviewCell
        let review = reviewList![indexPath.row].review!
        ImageLib.sharedInstance().download(for: (review.user?.profile_image)!, mountOver: cell.reviewerImageView)
        cell.reviewerName.text = review.user?.name
        cell.ratinglbl.text = "\(review.rating!)"
        cell.ratingView.backgroundColor = UIColor(hexString: review.rating_color!)
        cell.ratingtxtlbl.text = review.rating_text
        cell.reviewlbl.text = review.review_text
        cell.reviewCountlbl.text = "\(review.likes!)"
        cell.commentCountlbl.text = "\(review.comments_count!)"
        cell.reviewtimelbl.text = review.review_time_friendly
        
        return cell
    }
}
