//
//  ListDataModel.swift
//  Danggn
//
//  Created by 김담인 on 2022/05/26.
//

import Foundation

struct ListDataModel {
    let listImage: String
    let listTitle: String
    let listLocation: String
    let listPrice: String
    let listLikeCount: Int
}

extension ListDataModel {
    static let samleData: [ListDataModel] = [
        ListDataModel(
            listImage: "image1",
            listTitle: "기본 셔츠 반팔",
            listLocation: "수원시 영통구",
            listPrice: "23,000원",
            listLikeCount: 111),
        ListDataModel(
            listImage: "image2",
            listTitle: "기본 셔츠 반팔",
            listLocation: "수원시 영통구",
            listPrice: "23,000원",
            listLikeCount: 111),
        ListDataModel(
            listImage: "image1",
            listTitle: "기본 셔츠 반팔",
            listLocation: "수원시 영통구",
            listPrice: "23,000원",
            listLikeCount: 111),
        ListDataModel(
            listImage: "image2",
            listTitle: "기본 셔츠 반팔",
            listLocation: "수원시 영통구",
            listPrice: "23,000원",
            listLikeCount: 111),
        ListDataModel(
            listImage: "image1",
            listTitle: "기본 셔츠 반팔",
            listLocation: "수원시 영통구",
            listPrice: "23,000원",
            listLikeCount: 111),
        ListDataModel(
            listImage: "image1",
            listTitle: "기본 셔츠 반팔",
            listLocation: "수원시 영통구",
            listPrice: "23,000원",
            listLikeCount: 111)
    ]
}
