//
//  FeedCreateModel.swift
//  Danggn
//
//  Created by 황찬미 on 2022/06/19.
//

import Foundation

struct FeedCreateModel: Codable {
    let status: Int
    let message: String
    let success: Bool
    let data: FeedCreateData
}

struct FeedCreateData: Codable {
    let id: String
}
