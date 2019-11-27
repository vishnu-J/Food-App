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
    
    lazy var memorylevelCache = MemoryCache()
    
    private let downloadManager = DownloadManager()
    
    private let imageProcessor = ImageProcessor()
    
    public var cacheLevel : CacheType = .Memory
    
    public var enableDebugLog = false
    
    private static var instance : ImageLib?
    
    private override init() {
        super.init()
    }
    
    public static func sharedInstance() -> ImageLib{
        if instance == nil{
            instance = ImageLib()
        }
        return instance!
    }
    
    public func download(for url: String,mountOver imageView: UIImageView) {
        
        if url.isEmpty{
            Logger.i(tag: TAG, message: "Invalid URL")
            return
        }
        
        switch self.cacheLevel {
        case .Memory:
//            if let image = Cache.sharedInstance().memorylevelCache.get(url: url){
//                Logger.i(tag: TAG, message: "Image alreday Cached")
//                imageView.image = image
//                return
//            }
            if let image = self.memorylevelCache.get(url: url){
                Logger.i(tag: TAG, message: "Image alreday Cached")
                imageView.image = image
                return
            }
        case .Disk:
            print("disk level Cache Not Available")
            
//            let cachedImagedata = DiskCache.readFile(url: url)
//            if let data = cachedImagedata{
//                imageView.image = UIImage(data: data)
//                return
//            }
            
            
        default:
            print("No cache required")
        }
        
        downloadManager.downloadAsset(urlString: url) { (success, imageData, error) in
            if success{
                DispatchQueue.main.async {
                self.imageProcessor.processImage(data: imageData!, url: url, imageHolder: imageView)
                }
            
            }else{

            }
        }
    }
    
    func isBaseDirectoryCreated() -> Bool{
        return UserDefaults.standard.bool(forKey: Constants.KEY_FOR_DIRECTORY.rawValue)
    }
    
    func createBaseDirectory(){
        DiskCache.createDirectory(url: URL(string: Constants.BASE_PATH.rawValue)!)
    }
    
}

