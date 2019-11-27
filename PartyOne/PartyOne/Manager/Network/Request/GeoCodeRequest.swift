//
//  GeoCodeRequest.swift
//  PartyOne
//
//  Created by Vishnu on 26/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation

class GeoCodeRequest: PONetworkBase, NetworkProtocol {
    
    typealias PONetworkReturnType = RestaurantNearME
    
    private let locationDict : [String:String]
    
    init(location:[String:String]){
        self.locationDict = location
    }
    
    func makeRequest(completion: @escaping (RestaurantNearME?, String?) -> ()) {
        
        self.router.request(.GeoCode(location: locationDict)) { (data, response, error) in
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
                        let apiResponse = try JSONDecoder().decode(RestaurantNearME.self, from: responseData)
                        
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
