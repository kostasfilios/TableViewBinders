//
//  ImageView.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 25/7/22.
//

import UIKit

extension UIImageView {
    func set(imageURL: String?, defaultImage: UIImage? = nil, cache: Bool = false) {
        UIImage.get(imageURL: imageURL, defaultImage: defaultImage, cache: cache) { imageData in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.image = imageData
            }
        }
    }
}

extension UIImage {
    
    static func get(imageURL: String?, defaultImage: UIImage? = nil, cache: Bool = false, callBack: @escaping (UIImage?) -> ()) {
        callBack(defaultImage)
        guard  let imageURL = imageURL else { return }
        /// Chaeck if image exists in Cache
        if let image = Cache.imageWithIdentifier(imageURL) {
            callBack(image)
            return
        }
        guard let url = URL(string: imageURL) else { return }
        let session = URLSession.shared
        var mutableRequest = URLRequest(url: url)
        mutableRequest.httpMethod = "GET"
        mutableRequest.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        mutableRequest.timeoutInterval = 100.0
        
        session.dataTask(with: mutableRequest, completionHandler: { (data, response, error) in
            /// Continue if there are data and response, otherwise return with the returned error
            guard let data = data, let _:URLResponse = response, error == nil else {
                /// Return completion block with error
                return
            }
            guard let image = UIImage(data: data) else {
                ///   Completion error cant parse data to UIImage
                return
            }
            if cache {
                Cache.store(image, withIdentifier: imageURL)
            }
            callBack(image)
        }).resume()
    }
}
