//
//  DownloadManager.swift
//  Image_Loading_Library
//
//  Created by Vishnu on 28/09/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation

class DownloadManager  {
    
    final let TAG = "Dow_magr"
    
    init() {}
    
    
    public func downloadAsset(urlString: String, completion: @escaping (Bool, Data?, String?) -> ()) {
        
        Logger.d( TAG, "Download Manager Called")
        
        if urlString.isEmpty{
            Logger.i( TAG, "INVALID_URL")
            return
        }
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                guard data != nil , response != nil, error == nil else {
                    Logger.i(self.TAG, "Download Failed for url : \(urlString)")
                    completion(false,nil, error?.localizedDescription)
                    return
                }
                
                Logger.i( self.TAG, "Downloaded the Image successfully for the url : \(urlString)")
                
                completion(true,data!, nil)
            }.resume()
        } else {
            Logger.d( self.TAG, "Failed to download the file: \(urlString) after resolving was found to be nil")
        }
    }
}
