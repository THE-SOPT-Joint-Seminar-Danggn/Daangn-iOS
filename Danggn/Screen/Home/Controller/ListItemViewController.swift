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
        setNavigationUI()
    }
    
    private func setNavigationUI() {

        let search = navigationItem.setRightButtonUI(self, imageName: UIImage(named: "icon_search"))
        let menu = navigationItem.setRightButtonUI(self, imageName: UIImage(named: "icon_menu"))
        let bell = navigationItem.setRightButtonUI(self, imageName: UIImage(named: "icon_bell"))
    
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 16
        navigationItem.rightBarButtonItems = [bell, spacer, menu, spacer, search]
    
        // LeftBarButtonItem 설정
        // 여백을 주기 위해 동네명을 UIButton으로 만들고 UIView에 담아 myArea라는 UIBarButtonItem애 customView로 대입
        let myAreaButton = UIButton(frame: CGRect(x: 10, y: 0, width: 50, height: 50))
        myAreaButton.setTitle("영통동", for: .normal)
        myAreaButton.setTitleColor(.label, for: .normal)
        myAreaButton.sizeToFit()
        
        let leftBarView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        leftBarView.addSubview(myAreaButton)
        
        let myArea = UIBarButtonItem(customView: leftBarView)
        navigationItem.leftBarButtonItem = myArea

    }
    
}

extension ListItemViewController {

}
