//
//  ListPhotoCollectionViewCell.swift
//  Danggn
//
//  Created by 황찬미 on 2022/06/17.
//

import UIKit

protocol ListPhotoDelegate: AnyObject {
    func didPressDeleteBtn(at index: Int)
}

class ListPhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ListPhotoCollectionViewCell"
    weak var delegate: ListPhotoDelegate?
    var indexPath: Int = 0
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func delegateBtnDidTap(_ sender: Any) {
        delegate?.didPressDeleteBtn(at: indexPath)
    }
}
