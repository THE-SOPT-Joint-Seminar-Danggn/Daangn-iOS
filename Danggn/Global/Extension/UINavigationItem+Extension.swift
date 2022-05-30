//
//  UINavigationItem.swift
//  Danggn
//
//  Created by 김담인 on 2022/05/19.
//

import UIKit

extension UINavigationItem {
    
    func setRightButtonUI(imageName: UIImage?) -> UIBarButtonItem {
        
        let button = UIButton(type: .system)
        button.setImage((imageName), for: .normal)
        button.tintColor = .label

        let barButtonItem = UIBarButtonItem(customView: button)
        barButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true

        return barButtonItem
    }
}
