//
//  Cache.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 25/7/22.
//

import UIKit

protocol Cachable {
    static func store(_ image: UIImage?, withIdentifier identifier: String)
    static func store(_ data: Data?, withIdentifier identifier: String)
    static func imageWithIdentifier(_ identifier: String?) -> UIImage?
    static func dataWithIdentifier(_ identifier: String?) -> Data?
}

struct Cache: Cachable {
    
    static let inMemoryCache = NSCache<AnyObject, AnyObject>()
    
    // MARK: Retreiving images
    static func imageWithIdentifier(_ identifier: String?) -> UIImage? {
        
        // 1. If the identifier is nil, or empty, return nil
        if identifier == nil || identifier! == "" {
            return nil
        }
        
        let path = cacheIdentifier(identifier!)
        
        // 2. Try the memory cache
        if let image = Cache.inMemoryCache.object(forKey: path as AnyObject) as? UIImage {
            return image
        }
        
        return nil
    }
    
    // MARK: Retreiving data
    static func dataWithIdentifier(_ identifier: String?) -> Data? {
        
        // 1. If the identifier is nil, or empty, return nil
        if identifier == nil || identifier! == "" {
            return nil
        }
        
        let path = cacheIdentifier(identifier!)
        
        // 2. Try the memory cache
        if let data = Cache.inMemoryCache.object(forKey: path as AnyObject) as? Data {
            return data
        }
        
        return nil
    }
    
    // MARK: Saving images
    static func store(_ image: UIImage?, withIdentifier identifier: String) {
        let path = cacheIdentifier(identifier)
        
        // 1. If the image is nil, remove images from the cache
        if image == nil {
            Cache.inMemoryCache.removeObject(forKey: path as AnyObject)
            
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch _ {}
            
            return
        }
        
        // 2. Otherwise, keep the image in memory
        Cache.inMemoryCache.setObject(image!, forKey: path as AnyObject)
        
    }
    
    // MARK: Helper
    static func cacheIdentifier(_ imageName: String) -> String {
        return "gr.BlueBrown.caches.\(imageName)"
    }
    
    // MARK: Saving data
    static func store(_ data: Data?, withIdentifier identifier: String) {
        let path = cacheIdentifier(identifier)
        
        // 1. If data is nil, remove images from the cache
        if data == nil {
            Cache.inMemoryCache.removeObject(forKey: path as AnyObject)
            
            return
        }
        
        // 2. Otherwise, keep data in memory
        Cache.inMemoryCache.setObject(data! as AnyObject, forKey: path as AnyObject)
    }
}
