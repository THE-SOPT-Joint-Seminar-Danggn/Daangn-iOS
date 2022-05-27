//
//  PostDetailTableViewCell.swift
//  Danggn
//
//  Created by 황찬미 on 2022/05/27.
//

import UIKit

class PostDetailTableViewCell: UITableViewCell {
    
    let itemDetailViewController = ItemDetailViewController()
    // cell을 구분하기 위한 identifier
    static let identifier = "PostDetailTableViewCell"
    
    @IBOutlet weak var postDetailTableView: UIView!
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var stateButton: UIButton!
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var postLable: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func stateButtonDidTap(_ sender: UIButton) {
    print("잘나오니?")
        let actionSheet = UIAlertController(title: "상태 변경", message: nil, preferredStyle: .actionSheet)
        
        let sellingAction = UIAlertAction(title: "판매중", style: .default) { _ in
            self.stateButton.titleLabel?.text = "판매중"
        }
        let reservedAction = UIAlertAction(title: "예약중", style: .default) { _ in
            self.stateButton.titleLabel?.text = "예약중"
        }
        let soldOutAction = UIAlertAction(title: "판매완료", style: .default) { _ in
            self.stateButton.titleLabel?.text = "판매완료"
        }
        
        let cancelAction = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        
        actionSheet.addAction(sellingAction)
        actionSheet.addAction(reservedAction)
        actionSheet.addAction(soldOutAction)
        actionSheet.addAction(cancelAction)
        
        // 쇽샥 코드
//        self.present(actionSheet, aninamted: true)
//        
        itemDetailViewController.present(actionSheet, animated: true)
    }
}
