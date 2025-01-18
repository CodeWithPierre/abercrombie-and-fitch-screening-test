//
//  ANFExploreCard.swift
//  ANF Code Test
//
//  Created by Pierre ILYAMUKURU on 1/17/25.
//

import Foundation

// MARK: - ANFExploreCard Structure
/// This struct represents the model for an explore card, used in the application.
struct ANFExploreCard: Codable {
    var title: String?
    var backgroundImage: String?
    var content: [Content]?
    var promoMessage: String?
    var topDescription: String?
    var bottomDescription: String?
    
    // MARK: - Content Structure
    /// This struct represents individual content elements inside the explore card.
    struct Content: Codable {
        var target: String?
        var title: String?
        var elementType: String?
    }
}
