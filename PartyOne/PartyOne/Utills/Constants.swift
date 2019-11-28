//
//  Constants.swift
//  Zomato
//
//  Created by Vishnu on 25/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation

class Constants {
    public static let RESTAURANT_IDENTIFIER = "restaurant_cell"
    public static let FOOD_IDENTIFIER = "food_cell"
    public static let REVIEW_IDENTIFIER = "review_cell"
    public static let FOOD_VC_SEGUE = "restaurantVC_seque"
    public static let EVENT_VC_SEGUE = "eventVC_segue"
    public static let USER_KEY = "ab55e514c4e978d0427076473946458d"
}

class RequestConstants {
    public static let CONTENT_VALUE = "application/json; charset=utf-8"
    public static let ACCEPT = "Accept"
    public static let USER_KEY = "user-key"
    public static let LATITUDE = "lat"
    public static let LONGTITUDE = "lon"
}

class UserDefaultConstant{
    static let LOC_ID = "z_loc_id"
    static let LOC_NAME = "z_loc_name"
    static let LOC_IMAGE_URL = "z_loc_image_url"
}

enum Entities : String{
    case LOCATION_DETAILS = "LocationDetails"
}



