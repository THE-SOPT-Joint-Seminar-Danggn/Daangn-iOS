//
//  CreatePostViewController.swift
//  Danggn
//
//  Created by 황찬미 on 2022/06/12.
//

import UIKit
import BSImagePicker
import Photos

class CreatePostViewController: UIViewController {
    
    private var photoModel: PhotoDataModel = PhotoDataModel()

    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var contextTextField: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var priceTextFiled: UITextField!
    @IBOutlet weak var priceOfferLabel: UILabel!
    @IBOutlet weak var priceOfferButton: UIButton! {
        didSet {
            priceOfferButton.isEnabled = false
        }
    }
    @IBOutlet weak var priceOfferTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewPlaceHolder()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        keyboardAddObserver()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        keyboardRemoveObserver()
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func backBtnDidTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func completionBtnDidTap(_ sender: UIButton) {
        feedCreate()
    }

    func textViewPlaceHolder() {
        postTextView.delegate = self
        postTextView.text = "내용을 작성해 주세요"
        postTextView.textColor = UIColor.opaqueSeparator
    }
    
    func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number)) ?? ""
    }
    
    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func priceEditingChanged(_ sender: UITextField) {
        priceOfferButton.isEnabled = priceTextFiled.hasText
        checkMaxLength(textField: priceTextFiled, maxLength: 11)
        
        if sender.text?.isEmpty == true {
            priceOfferLabel.textColor = .lightGray
            priceOfferButton.isEnabled = false
            priceOfferLabel.textColor = .lightGray
        } else {
            let priceNumber = priceTextFiled.text?.replacingOccurrences(of: ",", with: "")
            priceTextFiled.text = numberFormatter(number: Int(priceNumber ?? "") ?? 0)
            priceOfferLabel.textColor = .black
            priceOfferTextLabel.textColor = .black
            priceOfferButton.setImage(UIImage(named: "ios_icon_check-2"), for: .normal)
        }
    }
    
    func checkMaxLength(textField: UITextField, maxLength: Int) {
        if priceTextFiled.text?.count ?? 0 > maxLength {
            textField.deleteBackward()
        }
    }

    @IBAction func offerBtnDidTap(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    // MARK: 옵저버 생성
    func keyboardAddObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: 옵저버 해제
    func keyboardRemoveObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: 해당 키보드가 보이면
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let safeAreaHeight = self.view.safeAreaInsets.bottom
            
            UIView.animate(withDuration: 1) {
                self.bottomView.transform = CGAffineTransform(translationX: 0, y: -(keyboardHeight - safeAreaHeight))
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        self.bottomView.transform = .identity
    }
}

extension CreatePostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.opaqueSeparator {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 작성해 주세요"
            textView.textColor = UIColor.opaqueSeparator
        }
    }
    
    // MARK: textView의 높이를 유동적으로 주는 코드
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            // 350 이하일 때는 더이상 줄어들지 않게 하기
            if estimatedSize.height <= 350 {
            } else {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
    }
}

extension CreatePostViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoModel.userSelectedImages.count + 1
    }
    // 데이터를 어떻게 보여 줄 것인가?
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let addPhotoIdentifier = AddPhotoCollectionViewCell.identifier
        let listPhotoIdentifier = ListPhotoCollectionViewCell.identifier

        // 첫번째 cell
        if indexPath.item == 0 {
            guard let addCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: addPhotoIdentifier, for: indexPath)
                    as? AddPhotoCollectionViewCell else { fatalError("실패") }
            addCell.delegate = self
            addCell.countLabel.text = "\(photoModel.userSelectedImages.count)"
            
            return addCell
        } else {
            // 추가된 cell
            guard let listCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: listPhotoIdentifier, for: indexPath)
                    as? ListPhotoCollectionViewCell else { fatalError("실패") }
            listCell.delegate = self
            listCell.indexPath = indexPath.item

            // 사용자가 앨범에서 고른 사진이 있는 경우??
            if photoModel.userSelectedImages.count > 0 {
                listCell.photoImageView.image = photoModel.userSelectedImages[indexPath.item - 1]
            }
            return listCell
        }
    }
}

extension CreatePostViewController: AddImageDelegate {
    func didPickImagesToUpload(images: [UIImage]) {
        photoModel.userSelectedImages = images
        collectionView.reloadData()
    }
}

extension CreatePostViewController: ListPhotoDelegate {
    func didPressDeleteBtn(at index: Int) {
        photoModel.userSelectedImages.remove(at: index - 1)
        collectionView.reloadData()
    }
}

extension CreatePostViewController: UICollectionViewDelegateFlowLayout {
    // 셀 사이즈 고려, 셀 사이즈를 고려하게 되면 모든 셀의 크기가 동일해짐.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    // 셀들과 safeArea 사이의 간격을 설정하는 것.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension CreatePostViewController {
    func feedCreate() {
        guard let priceNumber = priceTextFiled.text?.replacingOccurrences(of: ",", with: ""),
              let price = Int(priceNumber),
              let title = titleTextField.text,
              let category = categoryTextField.text,
              let contents = postTextView.text else { return }
              let isPriceSuggestion = priceOfferButton.isSelected ? true : false
        
        FeedCreateService.shared.feedCreate(imageCount: photoModel.userSelectedImages.count,
                                            title: title,
                                            category: category,
                                            price: price,
                                            contents: contents,
                                            isPriceSuggestion: isPriceSuggestion) { response in
            switch response {
            case .success(let data):
                guard let data = data as? FeedCreateModel else { return }
                      let createData = data.data
                let detailModel = FeedDetailData.init(id: createData.id,
                                                      image: [""],
                                                      onSale: "0",
                                                      title: title,
                                                      category: category,
                                                      createdAt: "1분전",
                                                      view: 1,
                                                      price: price,
                                                      isPriceSuggestion: isPriceSuggestion,
                                                      isLiked: false,
                                                      user: User.init(profile: "",
                                                                      name: "짠미",
                                                                      region: "수원",
                                                                      id: ""))
                
                guard let itemDetailViewController = UIStoryboard(name: "ItemDetail",
                                                                  bundle: nil).instantiateViewController(
                    withIdentifier: "ItemDetailViewController")
                        as? ItemDetailViewController else { return }
                
                itemDetailViewController.fromPostCreate = true
                itemDetailViewController.feedId = detailModel.id
                itemDetailViewController.feedDetailData = detailModel
                self.navigationController?.pushViewController(itemDetailViewController, animated: true)
            default:
                return
            }
            
        }
    }
}
