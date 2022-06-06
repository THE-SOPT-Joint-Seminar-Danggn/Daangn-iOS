//
//  PostDetailTableViewCell.swift
//  Danggn
//
//  Created by 황찬미 on 2022/06/03.
//

import UIKit

// 액션시트를 띄우는 프로토콜 선언
protocol PostDetailTableViewCellDelegate: AnyObject {
    func presentActionSheet(_ cell: PostDetailTableCell)
}

class PostDetailTableCell: UITableViewCell {
    
    weak var delegate: PostDetailTableViewCellDelegate?
    var feedId: String?
    
    // cell을 구분하기 위한 identifier
    static let identifier = "PostDetailTableViewCell"
    
    @IBOutlet weak var postDetailTableView: UIView!
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var stateButton: UIButton!
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var postLable: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var viewLabel: UILabel!
    
    func setData(feedDetail: FeedDetailData) {
//        userProfileImage.image = UIImage(named: [feedDetail.user?.profile])
//        guard let feedDetail = feedDetail else { return }
        
        // String 값을 url로 불러와서 ... 이미지로 변환해 주기
        // 여기로 값이 자꾸 안 오는 이유는??????
//        getImage(imageURL: feedDetail.user.profile)
        userNameLabel.text = feedDetail.user.name
        addressLabel.text = feedDetail.user.region
        
        titleLable.text = feedDetail.title
        categoryLabel.text = feedDetail.category
        createdLabel.text = feedDetail.createdAt
        viewLabel.text = "조회 \(feedDetail.view)"
    }
    
//    func setData(feedDetail: PostDetailModel) {
//        userNameLabel.text = feedDetail.userName
//        addressLabel.text = feedDetail.userRegion
//        titleLable.text = feedDetail.title
//        categoryLabel.text = feedDetail.category
//        postLable.text = feedDetail.content
//        createdLabel.text = feedDetail.createdAt
//        viewLabel.text = feedDetail.view
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // feedId의 값을 넘어오기 위해서는???
        self.feedDetail(feedId: "628f3743b32d474b28bba948")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func stateButtonDidTap(_ sender: UIButton) {
        delegate?.presentActionSheet(self)
    }
}

// extension PostDetailTableViewCell {
//    func getImage(imageURL: String?) {
//        guard let imageURL = imageURL else { return }
//        let url = URL(string: imageURL)
//
//        DispatchQueue.global().async {
//            guard let url = url else {return}
//            if let data = try? Data(contentsOf: url) {
//                DispatchQueue.main.async {
//                 self.userProfileImage.image = UIImage(data: data)
//                }
//            }
//        }
//    }
// }

extension PostDetailTableCell {
    // 상품 상세 페이지 서버 통신
    func feedDetail(feedId: String) {
        FeedDetailService.shared.feedDetail(feedId: feedId) { response in
            switch response {
            case .success(let data):
                print(data)
                self.setData(feedDetail: data.data)
            default:
                print("아님?")
                }
            }
        }
    }
