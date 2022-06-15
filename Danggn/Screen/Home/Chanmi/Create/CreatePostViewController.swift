//
//  CreatePostViewController.swift
//  Danggn
//
//  Created by 황찬미 on 2022/06/12.
//

import UIKit

class CreatePostViewController: UIViewController {

    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewPlaceHolder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        keyboardAddObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        keyboardRemoveObserver()
    }

    func textViewPlaceHolder() {
        postTextView.delegate = self
        postTextView.text = "내용을 작성해 주세요"
        postTextView.textColor = UIColor.opaqueSeparator
    }
    
    // MARK: 옵저버 생성
    func keyboardAddObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
            }
            else {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
    }
}
