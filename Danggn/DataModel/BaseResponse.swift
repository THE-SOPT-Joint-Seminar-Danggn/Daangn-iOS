//
//  BaseResponse.swift
//  Danggn
//
//  Created by 황찬미 on 2022/06/01.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let status: Int
    let success: Bool?
    let message: String
    let data: T?
}

struct BlankData: Codable {
    
}
