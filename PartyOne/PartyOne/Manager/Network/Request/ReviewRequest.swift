//
//  ReviewRequest.swift
//  PartyOne
//
//  Created by Vishnu on 27/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation

class ReviewRequest : PONetworkBase, NetworkProtocol{
    typealias GGNetworkReturnType = Reviews
    
    let resId:String
    
    init(with restaurantId:String){
        self.resId = restaurantId
    }
    
    func makeRequest(completion: @escaping (Reviews?, String?) -> ()) {
        router.request(.Reviews(res_id: resId)) { (data, response, error) in
            if error != nil{
                completion(nil, "GeoCode request failed with error : \(String(describing: error?.localizedDescription))")
                return
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
                        let apiResponse = try JSONDecoder().decode(Reviews.self, from: responseData)
                        
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
