//
//  CuisineViewModel.swift
//  PartyOne
//
//  Created by Vishnu on 30/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation

class CuisineViewModel : NSObject{
    
    override init() {}
    
    func getCuisines(completion: @escaping (CuisineList?,String?) -> ()) {
        
        CuisinesRequest().makeRequest { (cuisineList, error) in
            if error == nil{
                completion(cuisineList, nil)
            }else{
                completion(nil, error!)
            }
        }
    }
}
