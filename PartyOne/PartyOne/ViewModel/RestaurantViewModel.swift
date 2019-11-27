//
//  RestaurantViewModel.swift
//  PartyOne
//
//  Created by Vishnu on 27/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation

class RestaurantViewModel :NSObject{
    
    override init() {
        
    }
    
    func makeReviewRequest(with res_ID:String, completion:@escaping(Reviews?,String?)->()) {
        ReviewRequest(with: res_ID).makeRequest { (review, error) in
            if error == nil{
                completion(review!, nil)
            }else{
                completion(nil,error)
            }
        }
    }
}
