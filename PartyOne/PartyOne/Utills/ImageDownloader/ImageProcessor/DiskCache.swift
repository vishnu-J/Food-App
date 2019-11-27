//
//  DiskCache.swift
//  Image_Loading_Library
//
//  Created by Vishnu on 30/09/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation

class DiskCache  {
    
    private static let TAG = "FileUtl"
    private let filemanager = FileManager.default
    
    static var basePath: URL? = {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        } catch {
            return nil
        }
    }()
    
    
    public static var greedygamePath: URL? = {
        var path = basePath?.appendingPathComponent("Local")
        createDirectory(url: path!)
        return path
    }()
    
    public static func delete(url: URL) -> Bool {
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            
        }
        return false
    }
    
    
    
    public static func createDirectory(url: URL) -> Bool {
        let fileManager = FileManager.default
        do {
            try fileManager.createDirectory(atPath: url.path, withIntermediateDirectories: true, attributes: [:])
            return true
        } catch {
            Logger.d(tag: TAG, message: "Not able to create the directory. \(error)")
            return false
        }
    }
    
    public static func moveFile(from: URL, to: URL) -> Bool {
        do {
            try FileManager.default.moveItem(at: from, to: to)
            return true
        } catch {
            Logger.d(tag: TAG, message: "File not able to save.\(error)")
        }
        return false
    }
    
    public static func isdirectoryExisists(path:String) -> Bool{
       let isExsists = FileManager.default.fileExists(atPath: path)
        if isExsists{
            return true
        }
        
        return false
    }
    
    public static func readFile(url: String?) -> Data? {
        guard let url = url else {
            return nil
        }
        let fileHandle = FileHandle(forReadingAtPath: url)
        
        let data = fileHandle?.readDataToEndOfFile()
        fileHandle?.closeFile()
        return data
    }
    
    public static func saveUIImageToPath(image : UIImage, pathurl : URL) -> Bool {
        let filemanager = FileManager.default
        let imageData = image.pngData()
        var isImageSaved:Bool?
        
        guard let data = imageData else { return false }
        let path = pathurl.deletingLastPathComponent()
        
        let pathCreated = self.createDirectory(url: path)
        if pathCreated{
            isImageSaved = filemanager.createFile(atPath: pathurl.path, contents: data, attributes: nil)
            if isImageSaved! {
                Logger.d(tag: TAG, message: "Successfully saved the \(image) into the path -> \(pathurl)")
            }else{
                Logger.d(tag: TAG, message: "Failed to save the \(image) into the path -> \(pathurl)")
            }
        }
        
        return isImageSaved!
    }

}
