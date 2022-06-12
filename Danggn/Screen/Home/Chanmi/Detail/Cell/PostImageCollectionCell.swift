//
//  PostImageCollectionViewCell.swift
//  Danggn
//
//  Created by 황찬미 on 2022/05/27.
//

import UIKit

class PostImageCollectionCell: UICollectionViewCell {
    
    static let identifier = "PostImageCollectionCell"
    var pageCount: Int? {
        didSet {
            pageControl.numberOfPages = pageCount ?? 0
        }
    }
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        }
    
    func setData(feedImageData: String, pageControlIndex: Int) {
        getImage(imageURL: feedImageData)
        pageControl.currentPage = pageControlIndex
    }
}

// 페이지 컨트롤
extension PostImageCollectionCell: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / self.frame.width)
        pageControl.currentPage = page
    }
}

extension PostImageCollectionCell {
    func getImage(imageURL: String?) {
        guard let imageURL = imageURL else { return }
        let url = URL(string: imageURL)

        DispatchQueue.global().async {
            guard let url = url else {return}
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                 self.postImage.image = UIImage(data: data)
                }
            }
        }
    }
}
