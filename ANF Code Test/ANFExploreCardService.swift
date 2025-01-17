//
//  ANFExploreCardService.swift
//  ANF Code Test
//
//  Created by Pierre ILYAMUKURU on 1/17/25.
//

import Foundation
enum ANFExploreCardError: Error {
    case invalidURLString
    case responseDataError
    case decodingError
    case serviceError(Error)
}

class ANFExploreCardService {
    
    static let shared = ANFExploreCardService()
    private let urlString = "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.css"
    
    func getANFExploreCard(completion: @escaping (Result<[ANFExploreCard], ANFExploreCardError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURLString))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.serviceError(error)))
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
