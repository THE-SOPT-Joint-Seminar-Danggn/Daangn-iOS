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
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setData(postImageData: PostImageModel) {
        postImage.image = UIImage(named: postImageData.postImageName)
    }
}

extension PostImageCollectionCell: UICollectionViewDelegate {
    // feed collectionView를 스크롤하면 pageControl도 알맞은 위치로 변경
    // 색깔이 변하지 않음...
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let page = Int(targetContentOffset.pointee.x / self.frame.width)
        pageControl.currentPage = page
        
        if pageControl.currentPage != page {
            pageControl.currentPage = page
        }
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
