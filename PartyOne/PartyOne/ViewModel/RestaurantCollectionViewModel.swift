//
//  FoodViewModel.swift
//  PartyOne
//
//  Created by Vishnu on 26/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation

class RestaurantCollectionViewModel : NSObject {
    
    override init() { }
    
    func getRestaurantCollections(completion: @escaping(RestaurantsCollection?,String?) -> ()){
        
        RestaurantCollectionRequest().makeRequest { (res_collection, error) in
            if error == nil{
                completion(res_collection, nil)
            }else{
                completion(nil,error)
            }
        }
    }
}
