//
//  PostImageTableViewCell.swift
//  Danggn
//
//  Created by 황찬미 on 2022/05/27.
//

import UIKit

class PostImageTableViewCell: UITableViewCell, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var feedImageData: [String]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    static let identifier = "PostImageTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setPostImageCollection()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // postImageNib 함수
    func setPostImageCollection() {
        let postImageNib = UINib(nibName: PostImageCollectionCell.identifier, bundle: nil)
        collectionView.register(postImageNib, forCellWithReuseIdentifier: PostImageCollectionCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension PostImageTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    }
    
    // 몇 개의 셀을 보여 줄 것인지
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return feedImageData?.count ?? 0
}
    
    // 셀을 어떻게 보여 줄 것인지
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PostImageCollectionCell.identifier, for: indexPath)
                as? PostImageCollectionCell else { return UICollectionViewCell() }
        guard let feedImageData = feedImageData else { return UICollectionViewCell() }
        cell.pageCount = feedImageData.count
        cell.setData(feedImageData: feedImageData[indexPath.row], pageControlIndex: indexPath.row)
        
        return cell
    }
}

extension PostImageTableViewCell: UICollectionViewDelegateFlowLayout {
    // lineSpacing으로 셀간의 간격을 0을 줌
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
