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

    private var cacheDictionary = [String:UIImage]()

    func cacheImage(image:UIImage, for url:String){
        cacheDictionary[url] = image
    }
    
    func getCacheImage(url: String) -> UIImage?{
        if url.isEmpty{
            print("The url is empty.")
            return nil
        }
        
        guard let image = cacheDictionary[url] else { return nil }
        return image
    }
    
    func removeCacheImage(url: String) {
        if url.isEmpty{
            print("The url is empty.")
            return
        }
        
        self.cacheDictionary.removeValue(forKey: url)
    }
    
    func clearCache() {
        self.cacheDictionary.removeAll()
    }
    
    func count() -> Int{
        return cacheDictionary.count
    }
}
