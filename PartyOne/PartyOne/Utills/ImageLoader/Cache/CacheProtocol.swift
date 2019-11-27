//
//  CacheProtocol.swift
//  Image_Loading_Library
//
//  Created by Vishnu on 28/09/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation
import UIKit

protocol CacheProtocol {
    func cacheImage(image:UIImage, for url:String)
    func getCacheImage(url:String) -> UIImage?
    func removeCacheImage(url:String)
    func clearCache()
    func count() -> Int
}
