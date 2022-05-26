//
//  PostImageCollectionViewCell.swift
//  Danggn
//
//  Created by 황찬미 on 2022/05/27.
//

import UIKit

class PostImageCollectionCell: UICollectionViewCell {
    
    static let identifier = "PostImageCollectionCell"

    @IBOutlet weak var postImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(postImageData: PostImageModel) {
        postImage.image = UIImage(named: postImageData.postImageName)
    }

}

// 임의로 만든 더미데이터
struct PostImageModel {
    let postImageName: String
    var postImage: UIImage? {
        return UIImage(named: postImageName)
    }
}

extension PostImageModel {
    static let sampleData: [PostImageModel] = [
    PostImageModel(postImageName: "imageDetail_1"),
    PostImageModel(postImageName: "imageDetail_2"),
    PostImageModel(postImageName: "imageDetail_3")
    ]
}
