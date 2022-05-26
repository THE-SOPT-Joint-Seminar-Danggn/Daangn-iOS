//
//  PostImageTableViewCell.swift
//  Danggn
//
//  Created by 황찬미 on 2022/05/27.
//

import UIKit

class PostImageTableViewCell: UITableViewCell, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    static let identifier = "PostImageTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setPostImageCollection()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setPostImageCollection() {
        let postImageNib = UINib(nibName: PostImageCollectionCell.identifier, bundle: nil)
        collectionView.register(postImageNib, forCellWithReuseIdentifier: PostImageCollectionCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension PostImageTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PostImageModel.sampleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostImageCollectionCell.identifier, for: indexPath) as? PostImageCollectionCell else { return UICollectionViewCell() }
        
        cell.setData(postImageData: PostImageModel.sampleData[indexPath.row])
        
        return cell
    }
}

// 이 코드 때문에 사진이 엄청 확대대서 나타났었음. 계산해 주는 곳에서 잘못 구현된 것 같다
extension PostImageTableViewCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = UIScreen.main.bounds.height
//
//        // 이 부분 계산 안 해 주어도 되는지?
//        let cellHeight = height
//        let cellWidth = cellHeight
//
//        return CGSize(width: cellWidth, height: cellHeight)
//    }
    // lineSpacing 위, 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
