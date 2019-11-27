//
//  Cache.swift
//  Image_Loading_Library
//
//  Created by Vishnu on 28/09/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation
import UIKit

class MemoryCache : CacheProtocol {

    final let TAG = "Mem_Cache"
 
    private var cacheDictionary = [String:UIImage]()
    
    init() {}
    
    func set(url: String, for image:UIImage) {
        if url.isEmpty{
            Logger.d(tag: TAG , message: "Cache failed")
            return
        }
        
        self.cacheDictionary[url] = image
        Logger.d(tag: TAG , message: "Cached successfully")
    }
    
    
    func get(url: String) -> UIImage?{
        if url.isEmpty{
            Logger.d(tag: TAG, message: "Fetching Cached image failed")
            return nil
        }
        
        guard let image = cacheDictionary[url] else { return nil }
        return image
    }
    
    func evict(url: String) {
        if url.isEmpty{
            print("The url is empty.")
            return
        }
        
        self.cacheDictionary.removeValue(forKey: url)
    }
    
    func clearCache() {
        self.cacheDictionary.removeAll()
    }
    
}
