//
//  ListItemViewController.swift
//  Danggn
//
//  Created by 김담인 on 2022/05/18.
//

import UIKit

class ListItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      let storyBoard = UIStoryboard(name: "ItemDetail", bundle: nil)
      let viewController = storyBoard.instantiateViewController(withIdentifier: "ItemDetailViewController")
      self.navigationController?.pushViewController(viewController, animated: true)
    }

}
