//
//  ANFExploreCardService.swift
//  ANF Code Test
//
//  Created by Pierre ILYAMUKURU on 1/17/25.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping @Sendable(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

// MARK: - ANFExploreCardError Enum
/// This enum defines different types of errors that can occur when working with an `ANFExploreCard`.
enum ANFExploreCardError: Error {
    case invalidURLString
    case responseDataError
    case decodingError
    case serviceError
}

// MARK: - ANFExploreCardService Class
/// This class is responsible for fetching the explore card data from a remote service.
class ANFExploreCardService: ANFExploreCardServiceProtocol {
    
    static let shared = ANFExploreCardService()
    
    // MARK: - Private Properties
    private var urlString: String
    private var session: URLSessionProtocol
    
    init(urlString: String = "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.css",
         session: URLSessionProtocol = URLSession.shared) {
        self.urlString = urlString
        self.session = session
    }
    
    // MARK: - Public Methods
    
    /// Fetches the explore card data from the specified URL and handles success or failure using a completion handler.
    ///
    /// - Parameter completion: A closure that returns a `Result` containing either an array of `ANFExploreCard` on success or an `ANFExploreCardError` on failure.
    func getANFExploreCard(completion: @escaping (Result<[ANFExploreCard], ANFExploreCardError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURLString))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                completion(.failure(.serviceError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.responseDataError))
                return
            }
            
            do {
                let promotions = try JSONDecoder().decode([ANFExploreCard].self, from: data)
                completion(.success(promotions))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

extension URLSession: URLSessionProtocol, Sendable {}
