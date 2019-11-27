//
//  UserDefaultManager.swift
//  PartyOne
//
//  Created by Vishnu on 26/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation

/// List of keys to store and fetch the data from UserDefaults
///
/// - CITY_DETAILS: is used to store and get the current location details
enum DefaultKey : String{
    case CITY_DETAILS = "city details" /**current location details with id, name and country image url in a dictionary form **/
}

class UserDefaultManager {
    
    private static let  poDefault = UserDefaults.standard
    
    ///  used to store the data in userDefault
    /// - Parameters:
    ///   - data: data to be store
    ///   - key: for the respective key
    static func save(data:Any, for key:DefaultKey){
        poDefault.set(data, forKey: key.rawValue)
    }
    
    /// used to get data in userDefault
    ///
    /// - Parameter key: to get the respective value of the key
    static func get(datafor key:DefaultKey) ->  Any{
        return poDefault.object(forKey: key.rawValue)!
    }
}
