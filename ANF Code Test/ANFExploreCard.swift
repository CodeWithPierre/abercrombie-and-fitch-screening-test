//
//  ANFExploreCard.swift
//  ANF Code Test
//
//  Created by Pierre ILYAMUKURU on 1/17/25.
//

import Foundation

struct ANFExploreCard: Codable {
    var title: String?
    var backgroundImage: String?
    var content: [Content]?
    var promoMessage: String?
    var topDescription: String?
    var bottomDescription: String?
    
    // MARK: - Content
    struct Content: Codable {
        var target: String?
        var title: String?
        var elementType: String?
    }
}
