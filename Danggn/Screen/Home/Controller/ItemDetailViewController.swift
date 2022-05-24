//
//  DetailItemViewController.swift
//  Danggn
//
//  Created by 황찬미 on 2022/05/19.
//

import UIKit

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var proposalPriceLabel: UILabel!
    
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    var toggleButtonChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChatButton()
        likeButtonNotSelected()
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
        likeButton.setImage(UIImage(named: "icon_heart_off"), for: .normal)
    }
    
    func likeButtonSelected() {
        likeButton.setImage(UIImage(named: "icon_heart_on"), for: .normal)
    }
    
    private func setChatButton() {
        chatButton.layer.cornerRadius = 5
    }
}
