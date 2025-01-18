//
//  ANFExploreCardImageService.swift
//  ANF Code Test
//
//  Created by Pierre ILYAMUKURU on 1/17/25.
//

import Foundation
import UIKit


class ANFExploreCardImageService {
    // Singleton instance for shared usage
    static let shared = ANFExploreCardImageService()
    
    // Cache to store images for quick access
    private let cache = NSCache<NSURL, UIImage>()
    
    // Private initializer to prevent instantiation outside of this class
    private init() {}
    
    /// Asynchronously loads an image from a given URL
    /// - Parameters:
    ///   - url: The URL of the image to load
    ///   - completion: The closure that gets called with the loaded image or nil if an error occurred
    func loadAsyncImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        // Check if the image is already cached
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return
        }
        
        // Download the image asynchronously if not in cache
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, error == nil, let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil) // Return nil if loading fails
                }
                return
            }
            
            // Cache the successfully loaded image
            self.cache.setObject(image, forKey: url as NSURL)
            
            // Return the image on the main thread
            DispatchQueue.main.async {
                completion(image)
            }
        }
        
        // Set high priority for the network task to ensure faster loading
        task.priority = URLSessionTask.highPriority
        
        // Start the network task
        task.resume()
    }
}
