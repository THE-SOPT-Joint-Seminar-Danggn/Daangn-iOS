//
//  ListItemCollectionViewCell.swift
//  Danggn
//
//  Created by 김담인 on 2022/05/25.
//

import UIKit

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
    
    func setData(listData: ListDataModel) {
        listImageView.image = UIImage(named: listData.listImage)
        listTitleLabel.text = listData.listTitle
        listLocationLabel.text = listData.listLocation
        listPriceLabel.text = listData.listPrice
        listLikeCount.text = "\(listData.listLikeCount)"
    }
    
    func setBorder() {
        listItemBorderView.clipsToBounds = true
        listItemBorderView.layer.cornerRadius = 10
        listItemBorderView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
}
