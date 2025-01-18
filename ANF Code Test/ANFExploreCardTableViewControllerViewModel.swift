//
//  ANFExploreCardTableViewControllerViewModel.swift
//  ANF Code Test
//
//  Created by Pierre ILYAMUKURU on 1/17/25.
//

import Foundation

class ANFExploreCardTableViewControllerViewModel {
    static let cellIdentifier = "exploreContentCell"
    typealias Service = ANFExploreCardService
    var exploreCard: [ANFExploreCard] = []
    
    func getExploreCard(completion: @escaping (Error?) -> Void) {
        Service.shared.getANFExploreCard { [weak self] result in
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
