//
//  APIConstants.swift
//  Danggn
//
//  Created by 김담인 on 2022/05/27.
//

struct APIConstants {
    // MARK: - Base URL
    static let baseURL = "http://13.125.157.62:8000"
    
    // MARK: - Feature URL
    static let feedURL = baseURL + "/feed"
    
    static let detailFeedURL = baseURL + "/feed/"
    static let likeFeedURL = baseURL + "/feed/like/"
    static let feedOnSale = baseURL + "/feed/on-sale"
}
