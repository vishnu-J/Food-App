//
//  API.swift
//  Zomato
//
//  Created by Vishnu on 26/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation
import CoreLocation

public enum PartyOneAPI {
    case Categories
    case Cities(location:[String:String])
    case Collection
    case GeoCode(location:[String:String])
}

extension PartyOneAPI : EndPointType{
    
    
    var headers: HTTPHeaders? {
    
        switch self {
        case .Categories:
            return [:]
        case .Cities( _), .Collection, .GeoCode:
            var headers = [String:String]()
            headers[RequestConstants.USER_KEY] = Constants.USER_KEY
            return headers
        default:
            return [:]
        }
    }
    
    
    private static let TAG = "PtyOAPI"
    var environmentBaseURL : String {
        
        switch PONetworkBase.environment {
        case .production:
            return "https://developers.zomato.com/api/v2.1/"
        case .qa:
            return "https://developers.zomato.com/api/v2.1/"
        case .staging:
            return  "https://developers.zomato.com/api/v2.1/"
        }
    }
    
    var baseURL: URL? {
        switch self {
        case .Categories:
            guard var url = URL(string: "\(environmentBaseURL)") else {
                Logger.d(PartyOneAPI.TAG, "Categories not able to produce")
                return nil
            }
            return url
        case .Cities(let locationDict):
            
            guard var url = URL(string: "\(environmentBaseURL)") else {
                Logger.d(PartyOneAPI.TAG, "Cities not able to produce")
                return nil
            }
            
            
            url = getlocationURL(url: url, loc_Dict: locationDict)!
            return url
            
        case .Collection:
            guard var url = URL(string: "\(environmentBaseURL)") else {
                Logger.d(PartyOneAPI.TAG, "Collection not able to produce")
                return nil
            }
            
            guard let finalURL = getRestaurantCollectionURL(url: url) else{return nil}

            url = finalURL
            return url
        case .GeoCode(let locationDict):
            guard var url = URL(string: "\(environmentBaseURL)") else{
                Logger.d(PartyOneAPI.TAG, "GeoCodeURL not able to produce")
                return nil
            }
            
            url = getlocationURL(url: url, loc_Dict: locationDict)!
            return url
        }
        
    }
    
    var path:String{
        switch self {
        case .Categories:
            return "/categories"
        case .Cities:
            return "cities"
        case .Collection:
            return "/collections"
        case .GeoCode:
            return "geocode"
        }
    }
    
    var httpMethod: HTTPMethod{
        switch self {
        case .Categories:
            return .get
        case .Cities:
            return .get
        case .Collection:
            return .get
        case .GeoCode:
            return .get
        }
    }
    
    var task: HTTPTask{
        switch self {
        case .Categories:
            return .requestDefault
            
        case .Cities, .Collection, .GeoCode:
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: nil, additionHeaders: headers)
            
        }
    }
    
}


extension PartyOneAPI{
    private func getlocationURL(url:URL, loc_Dict:[String:String]) -> URL?{
        var queryItems = [URLQueryItem]()
        for key in loc_Dict.keys{
            if let value = loc_Dict[key]{
                if !value.isEmpty {
                    queryItems.append(URLQueryItem(name: key, value: loc_Dict[key]))
                }
            }
        }
        
        let urlComps = NSURLComponents(string: url.absoluteString)!
        urlComps.queryItems = queryItems
        return urlComps.url
    }
    
    private func getRestaurantCollectionURL(url:URL) -> URL?{
        var queryItems = [URLQueryItem]()
        
        let locationDetails = UserDefaultManager.get(datafor: .CITY_DETAILS) as? [String:String]
        guard let locationId = locationDetails?[UserDefaultConstant.LOC_ID] else{
            print("location id is nil")
            return nil
        }
        queryItems.append(URLQueryItem(name: "city_id", value: locationId))
        let urlComps = NSURLComponents(string: url.absoluteString)!
        urlComps.queryItems = queryItems
        return urlComps.url!
    }
    
}
