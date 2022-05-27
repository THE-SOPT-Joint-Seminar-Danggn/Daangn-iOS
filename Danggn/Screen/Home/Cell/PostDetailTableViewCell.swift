//
//  PostDetailTableViewCell.swift
//  Danggn
//
//  Created by 황찬미 on 2022/05/27.
//

import UIKit

class PostDetailTableViewCell: UITableViewCell {
    
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
    
}
