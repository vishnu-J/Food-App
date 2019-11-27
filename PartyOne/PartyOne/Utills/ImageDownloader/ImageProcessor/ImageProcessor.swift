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
            Logger.d(tag: TAG, message: "Invalid Image data")
            return
        }
        
        imageHolder.image = image
        
        if imageHolder.image != nil{
            Logger.i(tag: TAG, message: "Image Processor Succes")
            
            switch ImageLib.sharedInstance().cacheLevel{
            case .Memory:
                ImageLib.sharedInstance().memorylevelCache.set(url: url, for: image)
            case .Disk:
                print("disk cache")
//               let _ = DiskCache.saveUIImageToPath(image: image, pathurl: URL(fileURLWithPath: url))
            default:
                print("No cache")
            }
            
        }else{
            Logger.i(tag: TAG, message: "Image Processor failed")
        }
    }
    
}
