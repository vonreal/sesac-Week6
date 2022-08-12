//
//  CameraViewController.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/12.
//

import UIKit

import YPImagePicker

class CameraViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    
    // UIImagePickerController
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
    }
}
