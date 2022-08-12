//
//  CameraViewController.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/12.
//

import UIKit

import Alamofire
import SwiftyJSON
import Toast
import YPImagePicker

class CameraViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    // UIImagePickerController - 1
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // UIImagePickerController - 2
        picker.delegate = self
    }
    
    // OpenSource
    // 권한은 다 허용 해주세요!
    // 실제 디바이스 빌드 해보세용. 시뮬레이터(카메라X)
    // 실제로 카메라를 쓸 때 권한 요청
    // 권한 문구 등도 내부적으로 구현
    @IBAction func YPImagePickerButtonClicked(_ sender: UIButton) {
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
                
                self.photoImageView.image = photo.image
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    // UIImagePickerController
    @IBAction func cameraButtonClicked(_ sender: UIButton) {
        // 카메라 사용 가능 여부 판단
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            self.view.makeToast("카메라가 사용이 불가능해유!")
            return
        }
        
        picker.sourceType = .camera
        picker.allowsEditing = true // default: false, 정방향으로 사진을 크롭하는 사각형이 나온다.
        
        present(picker, animated: true)
    }
    
    // UIImagePickerController
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
        // 포토 라이브러리 사용 가능 여부 판단
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            self.view.makeToast("포토 라이브러리가 사용이 불가능해유!")
            return
        }
        
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true)
    }
    
    @IBAction func saveToPhotoLibrary(_ sender: UIButton) {
        if let image = photoImageView.image {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            self.view.makeToast("이미지가 저장되었슈!")
        } else {
            self.view.makeToast("photoImageView에 이미지가 읍슈!")
        }
    }
    
}

// UIImagePickerController - 3
// 네비게이션 컨트롤러를 상속받고 있음.
extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // UIImagePickerController - 4 : 갤러리에서 사진을 선택하거나 카메라 촬영 후 사진을 USE PHOTO를 클릭했을때
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 원본, 편집, 메타 데이터 등 - infoKey
        if let image = info[.originalImage] as? UIImage {
            self.photoImageView.image = image
            dismiss(animated: true)
        } else {
            view.makeToast("저장할 이미지가 없슈!")
        }
        print(#function)
    }
    
    // UIImagePickerController - 5 : 좌측 상단 취소버튼 눌렀을 때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
    }
}
