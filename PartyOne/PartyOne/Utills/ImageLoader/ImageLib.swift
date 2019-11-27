//
//  AssetManager.swift
//  Image_Loading_Library
//
//  Created by Vishnu on 27/09/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation
import UIKit

open class ImageLib : NSObject {
    
    private final let TAG = "Image_lib"
    
    private let downloadManager = DownloadManager()
    
    private let imageProcessor = ImageProcessor()
    
    let memoryCache = MemoryCache()
    
    public static var cacheLevel : CacheType = .Memory
    
    public static var enableDebugLog = false
    
    private static var instance : ImageLib?
    
    public static func sharedInstance() -> ImageLib{
        if instance == nil{
            instance = ImageLib()
        }
        return instance!
    }
    
    public func download(for url: String,mountOver imageView: UIImageView) {
        
        if url.isEmpty{
            return
        }
        
        if let image = memoryCache.getCacheImage(url: url){
            print("Image for the url: \(url) is already downloaded")
            DispatchQueue.main.async {
                imageView.image = image
            }
            
            return
        }
        
        downloadManager.downloadAsset(urlString: url) { (success, imageData, error) in
            if success{
               self.imageProcessor.processImage(data: imageData!, url: url, imageHolder: imageView)
            }
        }
    }
    
    
}

