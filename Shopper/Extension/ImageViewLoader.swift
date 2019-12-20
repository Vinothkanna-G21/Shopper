//
//  ImageViewLoader.swift
//  Shopper

import Foundation
import UIKit

class ImageViewLoader: UIImageView {

    // MARK: - Constants

    let imageCache = NSCache<NSString, AnyObject>()

    // MARK: - Properties

    var imageURLString: String?
    
    /// Set the image from URL
    /// - Parameters:
    ///   - urlString: Image Url
    ///   - imageMode: ContentMode of ImageView
    func setUpImageFrom(urlString: String, imageMode: UIView.ContentMode) {
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url: url, imageMode: imageMode)
    }
    
    /// To download the image if not present in Cache
    /// - Parameters:
    ///   - url: url of Image
    ///   - imageMode: ContentMode of UIView
    func downloadImageFrom(url: URL, imageMode: UIView.ContentMode) {
        contentMode = imageMode
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
        } else {
            
            WebServiceManager.performGetMethod(url: url) { (data) in
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    self.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
                    self.image = imageToCache
                }
            }
        }
    }
}
