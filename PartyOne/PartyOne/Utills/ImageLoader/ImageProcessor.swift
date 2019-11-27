//
//  ProcessImage.swift
//  Image_Loading_Library
//
//  Created by Vishnu on 28/09/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation
import UIKit

class ImageProcessor  {
    
    final let TAG = "Img_proc"
    
    
    init() {}
    
    func processImage(data:Data, url:String, imageHolder:UIImageView)  {
        
        let imageFromData = UIImage(data: data)
        
        guard let image = imageFromData else {
            Logger.d(TAG, "Invalid Image data")
            return
        }
        
        DispatchQueue.main.async {
            imageHolder.image = image
            ImageLib.sharedInstance().memoryCache.cacheImage(image: image, for: url)
            if imageHolder.image == nil{
                Logger.i(self.TAG, "Image Processor failed")
            }else{
                Logger.i(self.TAG, "Image Processed Suceesfully")
            }
        }
        
    }
}
