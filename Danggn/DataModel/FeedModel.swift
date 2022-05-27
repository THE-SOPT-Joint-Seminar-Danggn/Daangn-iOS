//
//  FeedModel.swift
//  Danggn
//
//  Created by 김담인 on 2022/05/27.
//

import Foundation

struct FeedResponse: Codable {
    let status: Int
    let success: Bool?
    let message: String
    let data: [FeedData]?
}

struct FeedData: Codable {
    let id: String
    let tile: String
    let region: String
    let image: String
    let price: Int
    let createdAt: String
}
