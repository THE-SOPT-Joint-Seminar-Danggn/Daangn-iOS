//
//  AddPhotoCollectionViewCell.swift
//  Danggn
//
//  Created by 황찬미 on 2022/06/17.
//

import UIKit
import BSImagePicker
import Photos

protocol AddImageDelegate: AnyObject {
    func didPickImagesToUpload(images: [UIImage])
}

class AddPhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AddPhotoCollectionViewCell"
    var delegate: AddImageDelegate?
    
    var selectedAssets: [PHAsset] = [PHAsset]()
    var userSelectedImages: [UIImage] = [UIImage]()
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var imagePicker: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // imagePicker 버튼 구현
    @IBAction func imagePickerButton(_ sender: Any) {
        
        selectedAssets.removeAll()
        userSelectedImages.removeAll()
        
        let imagePicker = ImagePickerController()
        imagePicker.settings.selection.max = 10
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        
        let viewController = self.window?.rootViewController
        viewController?.presentImagePicker(imagePicker, select: { (_) in
            
        }, deselect: { (_) in

        }, cancel: { (_) in

        }, finish: { (assets) in
            print("aaa")
            for asset in 0..<assets.count {
                self.selectedAssets.append(assets[asset])
            }
          
            self.convertAssetToImages()
            self.delegate?.didPickImagesToUpload(images: self.userSelectedImages)
        })
        }
    
    // PHIimage를 UIimage로 변환
    func convertAssetToImages() {
            if selectedAssets.count != 0 {
                for asset in 0..<selectedAssets.count {
                    
                    let imageManager = PHImageManager.default()
                    let option = PHImageRequestOptions()
                    option.isSynchronous = true
                    var thumbnail = UIImage()
                    
                    imageManager.requestImage(for: selectedAssets[asset],
                                              targetSize: CGSize(width: 200, height: 200),
                                              contentMode: .aspectFit,
                                              options: option) { (result, _) in
                        guard let result = result else { return }
                            thumbnail = result
                    }
                    
                    let data = thumbnail.jpegData(compressionQuality: 0.7)
                    
                    guard let data = data else { return }
                    guard let newImage = UIImage(data: data) else { return }
                    
                    self.userSelectedImages.append(newImage as UIImage)
                }
            }
        }
}
