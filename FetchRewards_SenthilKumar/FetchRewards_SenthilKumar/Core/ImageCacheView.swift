//
//  UIImageView+Extensions.swift
//  FetchRewards_SenthilKumar
//
//  Created by Senthil Kumar on 16/08/21.

import UIKit


let imageCache = NSCache<NSString, UIImage>()

class ImageCacheView: UIImageView {
    
    private var urlString: String?
    
    // MARK: Load Image Async
    func loadImage(url: URL) {
        
        self.urlString = url.absoluteString
        image = nil
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: data) else { return }
                
                if self.urlString == url.absoluteString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
            }
        }).resume()
    }
    
}
