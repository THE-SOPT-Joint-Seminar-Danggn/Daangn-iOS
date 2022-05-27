//
//  DetailItemViewController.swift
//  Danggn
//
//  Created by 황찬미 on 2022/05/19.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    private lazy var postCell = PostDetailTableViewCell()

    @IBOutlet weak var itemDetailTableView: UITableView!
    
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var proposalPriceLabel: UILabel!
    
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    var toggleButtonChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChatButton()
        likeButtonNotSelected()
        setPostImageTableView()
        setPostDetailTableView()
    }
    
    func setPostImageTableView() {
        let postImageNib = UINib(nibName: PostImageTableViewCell.identifier, bundle: nil)
        itemDetailTableView?.register(postImageNib, forCellReuseIdentifier: PostImageTableViewCell.identifier)
    
        itemDetailTableView?.delegate = self
        itemDetailTableView?.dataSource = self
        
//        itemDetailTableView.estimatedRowHeight = 375
//        itemDetailTableView.rowHeight = UITableView.automaticDimension
        
    }
    
    func setPostDetailTableView() {
        let postDetailNib = UINib(nibName: PostDetailTableViewCell.identifier, bundle: nil)
        itemDetailTableView?.register(postDetailNib, forCellReuseIdentifier: PostDetailTableViewCell.identifier)
        
        itemDetailTableView?.delegate = self
        itemDetailTableView?.dataSource = self
        
//        itemDetailTableView.estimatedRowHeight = 321
//        itemDetailTableView.rowHeight = UITableView.automaticDimension
        
    }

    @IBAction func homeButtonDidTap(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func chatButtonDIdTab(_ sender: UIButton) {
    }
    
    // 좋아요 버튼 눌렀을 떄 이벤트 구현
    @IBAction func likeButtonDidTab(_ sender: UIButton) {
        if toggleButtonChecked == false {
            toggleButtonChecked.toggle()
            likeButtonSelected()
        } else {
            toggleButtonChecked.toggle()
            likeButtonNotSelected()
        }
    }
    
    func likeButtonNotSelected() {
        likeButton?.setImage(UIImage(named: "icon_heart_off"), for: .normal)
    }
    
    func likeButtonSelected() {
        likeButton?.setImage(UIImage(named: "icon_heart_on"), for: .normal)
    }
    
    private func setChatButton() {
        chatButton?.layer.cornerRadius = 5
    }
}

// section 마다 크기를 주었더니 잘 보이게 됨.
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // section 마다 cell 다르게
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int
        
        switch section {
        case 0:
            count = 1
            // 이렇게 했을 때 3개가 나온 이유?
//          count = PostImageModel.sampleData.count
        case 1:
            count = 1
        default:
            count = 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // 이 부분 좀 더 이해하고 싶다
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostImageTableViewCell.identifier, for: indexPath) as? PostImageTableViewCell else { return UITableViewCell() }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailTableViewCell.identifier, for: indexPath) as? PostDetailTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension ItemDetailViewController: PostDetailTableViewCellDelegate {
    func presentActionSheet() {
        let actionSheet = UIAlertController(title: "상태 변경", message: nil, preferredStyle: .actionSheet)
        
        let sellingAction = UIAlertAction(title: "판매중", style: .default) { _ in
            self.postCell.stateButton?.titleLabel?.text = "판매중"
        }
        let reservedAction = UIAlertAction(title: "예약중", style: .default) { _ in
            self.postCell.stateButton?.titleLabel?.text = "예약중"
        }
        let soldOutAction = UIAlertAction(title: "판매완료", style: .default) { _ in
            self.postCell.stateButton?.titleLabel?.text = "판매완료"
        }
        
        let cancelAction = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        
        actionSheet.addAction(sellingAction)
        actionSheet.addAction(reservedAction)
        actionSheet.addAction(soldOutAction)
        actionSheet.addAction(cancelAction)
        
        // 쇽샥 코드
    self.present(actionSheet, animated: true)
    }
}
