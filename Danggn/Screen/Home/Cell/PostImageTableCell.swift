//
//  PostImageTableViewCell.swift
//  Danggn
//
//  Created by 황찬미 on 2022/05/27.
//

import UIKit

class PostImageTableCell: UITableViewCell, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var postImageData: [FeedDetailData] = []
//    var ImageData: [String] = []
    
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
    
//    func setData(feedDetail: FeedDetailData) {
//        feedDetail.index
//        collectionView(<#T##collectionView: UICollectionView##UICollectionView#>, cellForItemAt: )
//        collectionView.setData(feedDetail)
//    }
}

extension PostImageTableCell: UICollectionViewDataSource {
    
    // 몇 개의 셀을 보여 줄 것인지
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PostImageModel.sampleData.count
    }
    
    // 셀을 어떻게 보여 줄 것인지
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostImageCollectionCell.identifier, for: indexPath) as? PostImageCollectionCell else { return UICollectionViewCell() }
        
        cell.setData(postImageData: PostImageModel.sampleData[indexPath.row], pageControlIndex: indexPath.row)
//        cell.setData(postImageData: ImageData[indexPath.row], pageControlIndex: indexPath.row)
        
        return cell
    }
}

// 이 코드 때문에 사진이 엄청 확대돼서 나타났었음. 계산해 주는 곳에서 잘못 구현된 것 같다
extension PostImageTableCell: UICollectionViewDelegateFlowLayout {
    // lineSpacing으로 셀간의 간격을 0을 줌
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//extension PostImageTableViewCell {
//    // 상품 상세 페이지 서버 통신
//    func postImage(completion: @escaping () -> Void) {
//        FeedDetailService.shared.feedDetail(feedId: "628f3743b32d474b28bba948") { response in
//            switch response {
//            case .success(let data):
//                guard let postImageData = data as? BaseResponse<FeedDetailData> else { return }
//                self.postImageData = postImageData.data
//                completion()
//                print(postImageData.data)
//                print(postImageData)
//            default:
//                return
//            }
//        }
//    }
//}
