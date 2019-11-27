//
//  ViewControllerViewModel.swift
//  Zomato
//
//  Created by Vishnu on 26/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation
import CoreLocation

class ViewControllerViewModel: NSObject {
    
    private let locationHelper = LocationHelper()
    var locationDict = [String:String]()
    
    override init() {}
    
    func makeCityReQuest(completion: @escaping (Bool,String?) -> ()){
        let cityRequest = CityRequest(location: locationDict)
        cityRequest.makeRequest { (locationDetails, error) in
            if error == nil{
                let firstLocation = locationDetails?.location_suggestions?.first
                guard let location = firstLocation else{
                    return
                }
                DispatchQueue.main.async {
                    var details = [String:String]()
                    details[UserDefaultConstant.LOC_ID] = "\(String(describing: location.id!))"
                    details[UserDefaultConstant.LOC_NAME] = location.name
                    details[UserDefaultConstant.LOC_IMAGE_URL] = location.country_flag_url
                    UserDefaultManager.save(data: details, for: DefaultKey.CITY_DETAILS)
                }
               
                completion(true,nil)
            }else{
                completion(false,error)
            }
        }
    }
        
    func prepareLocation(location:CLLocation){
        self.locationDict[RequestConstants.LATITUDE] = "\(location.coordinate.latitude)"
        self.locationDict[RequestConstants.LONGTITUDE] = "\(location.coordinate.longitude)"
    }
    
    
    func getRestaurants(completion: @escaping ([Nearby_restaurants]?,String?) -> ()) {
        /*RestaurantCollectionRequest().makeRequest { (restaurant, error) in
            if error == nil{
                completion(restaurant?.collections ?? nil,nil)
            }else{
                completion(nil,error)
            }
        }*/
        GeoCodeRequest(location: locationDict).makeRequest { (restaurant, error) in
            if error == nil{
                completion(restaurant?.nearby_restaurants,nil)
            }else{
                completion(nil,error)
            }
        }
    }
    
    
}
