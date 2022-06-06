//
//  FeedDetailModel.swift
//  Danggn
//
//  Created by 황찬미 on 2022/06/02.
//

import Foundation

// MARK: - DataClass

struct FeedDetailModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: FeedDetailData
}

// MARK: - DataClass
struct FeedDetailData: Codable {
    let id: String
    let image: [String]
    let onSale, title, category, createdAt: String
    let view, price: Int
    let isPriceSuggestion, isLiked: Bool
    let user: User
}

// MARK: - User
struct User: Codable {
    let profile: String
    let name, region, id: String

    enum CodingKeys: String, CodingKey {
        case profile, name, region
        case id = "_id"
    }
}

