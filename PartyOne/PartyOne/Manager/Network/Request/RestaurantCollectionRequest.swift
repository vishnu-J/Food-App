//
//  RestaurantCollection.swift
//  PartyOne
//
//  Created by Vishnu on 26/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation

class RestaurantCollectionRequest : PONetworkBase, NetworkProtocol {
    typealias GGNetworkReturnType = RestaurantsCollection
    
    func makeRequest(completion: @escaping (RestaurantsCollection?, String?) -> ()) {
        router.request(.Collection) { (data, response, error) in
            if error != nil{
                completion(nil,(String(describing: error)))
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        _ = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        let apiResponse = try JSONDecoder().decode(RestaurantsCollection.self, from: responseData)
                        
                        completion(apiResponse,nil)
                    }catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
            
        }
    }
    
}
