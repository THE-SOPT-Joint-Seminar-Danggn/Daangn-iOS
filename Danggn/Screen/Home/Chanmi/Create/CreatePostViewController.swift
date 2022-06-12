//
//  CreatePostViewController.swift
//  Danggn
//
//  Created by 황찬미 on 2022/06/12.
//

import UIKit

class CreatePostViewController: UIViewController {
    
    @IBOutlet weak var postTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewPlaceHolder()
    }
    
    func textViewPlaceHolder() {
        postTextView.delegate = self
        postTextView.text = "내용을 작성해 주세요"
        postTextView.textColor = UIColor.opaqueSeparator
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
