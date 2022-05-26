//
//  DetailItemViewController.swift
//  Danggn
//
//  Created by 황찬미 on 2022/05/19.
//

import UIKit

class ItemDetailViewController: UIViewController, UITableViewDelegate {

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
    }
    
    func setPostImageTableView() {
        let postImageNib = UINib(nibName: PostImageTableViewCell.identifier, bundle: nil)
        itemDetailTableView.register(postImageNib, forCellReuseIdentifier: PostImageTableViewCell.identifier)
        
        itemDetailTableView.delegate = self
        itemDetailTableView.dataSource = self
        
        itemDetailTableView.estimatedRowHeight = 375
        itemDetailTableView.rowHeight = UITableView.automaticDimension
        
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

//extension ItemDetailViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 375
//    }
//}

extension ItemDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostImageTableViewCell.identifier, for: indexPath) as? PostImageTableViewCell else { return UITableViewCell() }
        return cell
    }
}
