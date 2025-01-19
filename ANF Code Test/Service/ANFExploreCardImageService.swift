//
//  ANFExploreCardImageService.swift
//  ANF Code Test
//
//  Created by Pierre ILYAMUKURU on 1/17/25.
//

import Foundation
import UIKit


class ANFExploreCardImageService {
    static let shared = ANFExploreCardImageService()
    private let cache = NSCache<NSURL, UIImage>()
    private init() {}
    
    /// Asynchronously loads an image from a given URL
    /// - Parameters:
    ///   - url: The URL of the image to load
    ///   - completion: The closure that gets called with the loaded image or nil if an error occurred
    func loadAsyncImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, error == nil, let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            self.cache.setObject(image, forKey: url as NSURL)
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.priority = URLSessionTask.highPriority
        task.resume()
    }
}
