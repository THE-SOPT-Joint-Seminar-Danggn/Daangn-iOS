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
    
    @IBAction func likeButtonDidTab(_ sender: UIButton) {
        if toggleButtonChecked == false {
            toggleButtonChecked = true
            likeButtonSelected()
        } else {
            toggleButtonChecked = false
            likeButtonNotSelected()
        }
    }
    
    @IBAction func chatButtonDIdTab(_ sender: UIButton) {
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
