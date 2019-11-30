//
//  Constants.swift
//  Zomato
//
//  Created by Vishnu on 25/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    public static let STORYBOARD_NAME = "Main"
    public static let RESTAURANT_IDENTIFIER = "restaurant_cell"
    public static let FOOD_IDENTIFIER = "food_cell"
    public static let REVIEW_IDENTIFIER = "review_cell"
    public static let MENU_IDENTIFIER = "menu_cell"
    public static let CUISINE_IDENTIFIER = "cuisine_cell"
    public static let RESTAURANT_COLLECTION_IDENTIFIER = "restaurantCollection_Cell"
    public static let RESTAURANT_COLLECTION_VC_ID = "res_coll_vc"
    public static let CUISINE_VC_ID = "cuisine_vc"
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

class External{
    
     static let TAG = "External"
    static func openSafari(withURL urlString:String){
        guard let url = URL(string: urlString) else {
            Logger.i(External.TAG, "Not able to produce the URL from the urString : \(urlString)")
            return
            
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:]) { (isOpened) in
                if isOpened{
                    Logger.d(External.TAG, "The url \(url) is opened by safari successfully")
                }else{
                    Logger.d(External.TAG, "The url \(url) is not able to open by safari")
                }
            }
        } else {//ios 9
            // Fallback on earlier versions
            let isOpened = UIApplication.shared.openURL(url)
            if !isOpened{
                Logger.d(External.TAG, "The url \(url) is not able to open by safari")
            }
        }
    }
    
}

class Alert{
    static func alert(message:String, actionTitle:String, vc: UIViewController){
        let alert = UIAlertController(title: "Alert", message:message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
}

class Loader{
    private static var loader = UIActivityIndicatorView()
    private static var bgView = UIView()
    
    static func showLoader(of view:UIView){
        bgView.frame = view.frame
        loader.frame = CGRect(x: ((view.frame.width/2) - 20), y: ((view.frame.height/2) - 20), width: 40, height: 40)
        bgView.addSubview(loader)
        loader.startAnimating()
        view.addSubview(bgView)
    }
    
    static func closeLoader(of view:UIView){
//        bgView.frame = view.frame
//        loader.frame = CGRect(x: ((view.frame.width/2) - 20), y: ((view.frame.height/2) - 20), width: 40, height: 40)
//        bgView.addSubview(loader)
        loader.stopAnimating()
        bgView.removeFromSuperview()
    }
}
