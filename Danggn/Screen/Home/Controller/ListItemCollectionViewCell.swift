//
//  ListItemCollectionViewCell.swift
//  Danggn
//
//  Created by 김담인 on 2022/05/25.
//

import UIKit
import Alamofire

class ListItemCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ListItemCollectionViewCell"

    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var listTitleLabel: UILabel!
    @IBOutlet weak var listLocationLabel: UILabel!
    @IBOutlet weak var listPriceLabel: UILabel!
    @IBOutlet weak var listLikeButton: UIButton!
    @IBOutlet weak var listLikeCount: UILabel!
    @IBOutlet weak var listItemBorderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBorder()
    }
    
    override func prepareForReuse() {
        super .prepareForReuse()
        
        listImageView.image = nil
    }
    
    func setData(feedData: FeedData) {
        getImage(imageURL: feedData.image)
        listTitleLabel.text = feedData.title
        listLocationLabel.text = feedData.region
        listPriceLabel.text = "\(feedData.price)원"
        listLikeCount.text = "12"
    }
    
    func setMockData(listData: ListDataModel) {
        listImageView.image = UIImage(named: listData.listImage)
        listTitleLabel.text = listData.listTitle
        listLocationLabel.text = listData.listLocation
        listPriceLabel.text = listData.listPrice
        listLikeCount.text = "\(listData.listLikeCount)"
    }
    
    func setBorder() {
        listItemBorderView.clipsToBounds = true
        listItemBorderView.layer.cornerRadius = 10
    }
}

// 이미지 비동기 처리
extension ListItemCollectionViewCell {
    func getImage(imageURL: String?) {
        guard let imageURL = imageURL else { return }
        let url = URL(string: imageURL)
        
        DispatchQueue.global().async {
            guard let url = url else {return}
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                 self.listImageView.image = UIImage(data: data)
                }
            }
        }
    }
}
