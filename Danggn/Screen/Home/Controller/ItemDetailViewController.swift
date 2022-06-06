//
//  DetailItemViewController.swift
//  Danggn
//
//  Created by 황찬미 on 2022/05/19.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    private lazy var postCell = PostDetailTableViewCell()
    
//    var feedDetailData: [FeedDetailData] {
//        didSet {
//            print(feedDetailData.id)
//            }
//        }
//    }
    
    var feedDetailData: [FeedDetailData]?
    var feedId: String?

    @IBOutlet weak var itemDetailTableView: UITableView!
    
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var proposalPriceLabel: UILabel!
    
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChatButton()
        likeButtonNotSelected()
        setPostImageTableView()
        setPostDetailTableView()
        if feedId = feedId {
            feedDetail(feedId: feedId)
        }
//        let url = URL(string: )
//
        
//        feedDetail {
//            print("아 제발 붙어주세요 ㅠㅠ")
//        }
        
//        self.feedDetail {
//            self.itemPriceLabel.text = "\(self.feedDetailData?.price)"
//            self.proposalPriceLabel.text = "\(self.feedDetailData?.price)"
//        }
    }
    
    func setPostImageTableView() {
        let postImageNib = UINib(nibName: PostImageTableViewCell.identifier, bundle: nil)
        itemDetailTableView?.register(postImageNib, forCellReuseIdentifier: PostImageTableViewCell.identifier)
    
        itemDetailTableView?.delegate = self
        itemDetailTableView?.dataSource = self
    }
    
    func setPostDetailTableView() {
        let postDetailNib = UINib(nibName: PostDetailTableViewCell.identifier, bundle: nil)
        itemDetailTableView?.register(postDetailNib, forCellReuseIdentifier: PostDetailTableViewCell.identifier)
        
        itemDetailTableView?.delegate = self
        itemDetailTableView?.dataSource = self
        
    }

    @IBAction func homeButtonDidTap(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func chatButtonDIdTap(_ sender: UIButton) {
    }
    
    // 좋아요 버튼 눌렀을 떄 이벤트 구현
    @IBAction func likeButtonDidTap(_ sender: UIButton) {
        feedLike()
        likeButton.isSelected.toggle()
        likeButton.isSelected ? likeButtonSelected() : likeButtonNotSelected()
    }
    
    func likeButtonNotSelected() {
        likeButton?.setImage(UIImage(named: "icon_heart_off"), for: .normal)
    }
    
    func likeButtonSelected() {
        likeButton?.setImage(UIImage(named: "icon_heart_on"), for: .normal)
    }
    
    func setChatButton() {
        chatButton?.layer.cornerRadius = 5
    }
}

// section 마다 높이를 주는 코드
extension ItemDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 375
        case 1:
            return 321
        default:
            return 0
        }
    }
}

extension ItemDetailViewController: UITableViewDataSource {
    
    // section의 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // section마다 포함될 row의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int
        
        switch section {
        case 0...1:
            count = 1
        default:
            count = 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostImageTableViewCell.identifier, for: indexPath) as? PostImageTableViewCell else { return UITableViewCell() }
//             일부 데이터 붙여 주어야 함
//            self.feedDetail {
//                cell.setData(feedDetail: self.feedDetailData)
//            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailTableViewCell.identifier, for: indexPath) as? PostDetailTableViewCell else { return UITableViewCell() }
            // 여기다 일부 데이터를 붙여 주어야 하는디
//            self.feedDetail {
//                cell.setData(feedDetail: self.feed)
//            }
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension ItemDetailViewController: PostDetailTableViewCellDelegate {
    func presentActionSheet(_ cell: PostDetailTableViewCell) {
        let actionSheet = UIAlertController(title: "상태 변경", message: nil, preferredStyle: .actionSheet)
        
        let sellingAction = UIAlertAction(title: "판매중", style: .default) { _ in
            cell.stateLabel?.text = "판매중"
            self.feedOnSale(onSale: "0")
        }
        let reservedAction = UIAlertAction(title: "예약중", style: .default) { _ in
            cell.stateLabel?.text = "예약중"
            self.feedOnSale(onSale: "1")
        }
        let soldOutAction = UIAlertAction(title: "판매완료", style: .default) { _ in
            cell.stateLabel?.text = "판매완료"
            self.feedOnSale(onSale: "2")
        }
        
        let cancelAction = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        
        actionSheet.addAction(sellingAction)
        actionSheet.addAction(reservedAction)
        actionSheet.addAction(soldOutAction)
        actionSheet.addAction(cancelAction)

        self.present(actionSheet, animated: true)
    }
}

extension ItemDetailViewController {
    // 상품 상세 페이지 서버 통신
    func feedDetail(feedId: String) {
        FeedDetailService.shared.feedDetail(feedId: feedId) { response in
            switch response {
            case .success(let data):
                print(feedId)
            default:
                return
            }
        }
    }
}

//extension ItemDetailViewController {
//    // 상품 상세 페이지 서버 통신
//    func feedDetail(completion: @escaping () -> Void) {
//        FeedDetailService.shared.feedDetail(feedId: "628f3743b32d474b28bba948") { response in
//            switch response {
//            case .success(let data):
//                guard let feedDetailData = data as? FeedDetailModel else { return }
//                completion()
//                print(feedDetailData.data)
//                print(feedDetailData)
//            default:
//                return
//            }
//        }
//    }
//}

extension ItemDetailViewController {
    // 상품 좋아요
    func feedLike() {
        FeedLikeService.shared.feedLike(feedId: "628f3743b32d474b28bba948") { response in
            switch response {
            case .success(let data):
                guard let data = data as? FeedLikeModel else { return }
                print(data)
            default:
                return
            }
        }
    }
}

extension ItemDetailViewController {
    // 상품 판매 상태 변경 요청
    func feedOnSale(onSale: String) {
        FeedOnSaleService.shared.feedOnSale(feedId: "628f3743b32d474b28bba948",
                                            onSale: onSale) { response in
            switch response {
            case .success(let data):
                guard let data = data as? FeedOnSaleModel else { return }
                print(data)
            default:
                return
            }
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
