//
//  ListItemViewController.swift
//  Danggn
//
//  Created by 김담인 on 2022/05/18.
//

import UIKit

class ListItemViewController: UIViewController {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyBoard = UIStoryboard(name: "ItemDetail", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ItemDetailViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
        
        setNavigationUI()
        registerCell()
    }
    
    @IBAction func itemCreateButtondidTap(_ sender: Any) {
        
    }
}

extension ListItemViewController {
    func setNavigationUI() {
        
        let navigationBar = UINavigationBarAppearance()
        navigationBar.shadowColor = .gray
        self.navigationController?.navigationBar.standardAppearance = navigationBar

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
        myAreaButton.titleLabel?.font = UIFont(name: "Roboto", size: 18)
        myAreaButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        myAreaButton.setTitleColor(.label, for: .normal)
        myAreaButton.sizeToFit()
        
        let leftBarView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        leftBarView.addSubview(myAreaButton)
        
        let myArea = UIBarButtonItem(customView: leftBarView)
        navigationItem.leftBarButtonItem = myArea
    }
}

extension ListItemViewController {
    
    // CollectionViewCell 등록
    func registerCell() {
        let nib = UINib(nibName: "ListItemCollectionViewCell", bundle: nil)
        listCollectionView.register(nib, forCellWithReuseIdentifier: "ListItemCollectionViewCell")
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
    }
}

extension ListItemViewController: UICollectionViewDelegate {
    
}

extension ListItemViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        ListDataModel.samleData.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            guard let cell = listCollectionView.dequeueReusableCell(
            withReuseIdentifier: "ListItemCollectionViewCell",
            for: indexPath) as? ListItemCollectionViewCell
            else { return UICollectionViewCell() }
        
            cell.setData(listData: ListDataModel.samleData[indexPath.row])
            return cell
    }
}

extension ListItemViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        
        let cellWidth = width
        let cellHeight = width * (136/375)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    }

}
