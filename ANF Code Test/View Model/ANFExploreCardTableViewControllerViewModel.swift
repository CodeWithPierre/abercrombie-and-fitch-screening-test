//
//  ANFExploreCardTableViewControllerViewModel.swift
//  ANF Code Test
//
//  Created by Pierre ILYAMUKURU on 1/17/25.
//

import Foundation

protocol ANFExploreCardServiceProtocol {
    func getANFExploreCard(completion: @escaping (Result<[ANFExploreCard], ANFExploreCardError>) -> Void)
}

// MARK: - ANFExploreCardTableViewControllerViewModel Class
/// This ViewModel class is responsible for managing the data related to the Explore Card.
/// It interacts with the `ANFExploreCardService` to fetch the explore card data and prepares it for presentation.
class ANFExploreCardTableViewControllerViewModel{
    static let cellIdentifier = "ANFExploreCardTableViewCell"
    static let shopMentext = "Shop Men"
    static let shopWomentext = "Shop Women"
    var exploreCard: [ANFExploreCard] = []
    typealias Service = ANFExploreCardServiceProtocol
    private var service: Service
    
    init(service: Service = ANFExploreCardService.shared) {
        self.service = service
    }
    
    /// Fetches the explore card data using the `ANFExploreCardService`.
    ///
    /// - Parameter completion: A closure that is called upon completion of the data fetch.
    ///                          It returns `nil` on success, or an error on failure.
    func getExploreCard(completion: @escaping (Error?) -> Void) {
        service.getANFExploreCard { [weak self] result in
            switch result {
            case .success(let exploreCard):
                self?.exploreCard = exploreCard
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
