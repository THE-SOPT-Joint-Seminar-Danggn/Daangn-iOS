//
//  ListItemViewController.swift
//  Danggn
//
//  Created by 김담인 on 2022/05/18.
//

import UIKit

class ListItemViewController: UIViewController {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    var feedDataList = [FeedData]() {
        didSet {
            listCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setNavigationUI()
        registerCell()
    }
    
    @IBAction func itemCreateButtonDidTap(_ sender: UIButton) {
        
    }
}

extension ListItemViewController {
    func setNavigationUI() {
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .gray
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance

        let search = navigationItem.setRightButtonUI(imageName: UIImage(named: "icon_search"))
        let menu = navigationItem.setRightButtonUI(imageName: UIImage(named: "icon_menu"))
        let bell = navigationItem.setRightButtonUI(imageName: UIImage(named: "icon_bell"))
    
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 16
        navigationItem.rightBarButtonItems = [bell, spacer, menu, spacer, search]

        // LeftBarButtonItem 설정
        // 여백을 주기 위해 동네명을 UIButton으로 만들고 UIView에 담아 myArea라는 UIBarButtonItem애 customView로 대입
        let myAreaButton = UIButton(frame: CGRect(x: 10, y: 0, width: 50, height: 50))
        myAreaButton.setTitle("경기동", for: .normal)
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
        let nib = UINib(nibName: ListItemCollectionViewCell.identifier, bundle: nil)
        listCollectionView.register(nib, forCellWithReuseIdentifier: ListItemCollectionViewCell.identifier)
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
    }
}

extension ListItemViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}

extension ListItemViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        print("numberOfItemsInSection")
        return feedDataList.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            print("cellForItemAt")
            guard let cell = listCollectionView.dequeueReusableCell(
            withReuseIdentifier: "ListItemCollectionViewCell",
            for: indexPath) as? ListItemCollectionViewCell
            else { return UICollectionViewCell() }
            cell.setData(feedData: feedDataList[indexPath.row])
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

extension ListItemViewController {
    func getData() {
        FeedService.shared.getImage { response in
            switch response {
            case .success(let feedResponse):
                guard let feedResponse = feedResponse as? FeedResponse else {return}
                guard let feedData = feedResponse.data else {return}
                self.feedDataList = feedData
            default:
                print("fail")
            }
        }
    }
}
