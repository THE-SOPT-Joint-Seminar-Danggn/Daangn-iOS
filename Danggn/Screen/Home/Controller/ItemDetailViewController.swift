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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChatButton()

    }

    @IBAction func homeButtonDidTap(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func likeButtonDidTab(_ sender: UIButton) {
    }
    
    @IBAction func chatButtonDIdTab(_ sender: UIButton) {
    }
    
    private func setChatButton() {
        chatButton.layer.cornerRadius = 5
    }
}
