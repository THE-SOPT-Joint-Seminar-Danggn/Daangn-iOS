//
//  FeedDetailModel.swift
//  Danggn
//
//  Created by 황찬미 on 2022/06/02.
//

import Foundation

struct FeedDetailData: Codable {
    let image: [String]
    let onSale: Int
    let title, category, createdAt, content: String
    let view: Int
    let price, isPriceSuggestion: String
    let isLiked: Bool
    let user: User?
}

// MARK: - User
struct User: Codable {
    let profile: String
    let name, area: String
}
