//
//  ClosureViewController.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/08.
//

import UIKit

class ClosureViewController: UIViewController {

    @IBOutlet weak var cardView: CardView!
    
    var sampleButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         위치, 크기, 추가
         
         오토리사이징을 오토레이아웃 제약조건처럼 설정해주는 기능이 내부적으로 구현되어 잇음.
         이 기능은 디폴트가 true, 하지만 오토레이아웃을 지정해주면 오토리사이징을 안 쓰겠다는 의미인 false로 상태가 내부적으로 변경됨! 오토리사이징과 오토레이아웃이 함께면 충돌이 남
         
         코드 기반 UI -> true
         인터페이스 빌더 기반 UI -> false
         
         autoresizing -> autolayout constraints
         */
        
        sampleButton.frame = CGRect(x: 100, y: 400, width: 100, height: 100)
        sampleButton.backgroundColor = .yellow
        view.addSubview(sampleButton)
        
        cardView.posterImageView.backgroundColor = .white
        cardView.posterImageView.layer.borderColor = UIColor.lightGray.cgColor
        cardView.posterImageView.layer.borderWidth = 1
        cardView.likeButton.tintColor = .systemPink
    }
    
    @objc func likebuttonClicked() {
        print("click button")
    }
    
    @IBAction func colorPicekrButtonClicked(_ sender: UIButton) {
        showAlert(title: "피커를 띄웁ㅁ니다", message: nil, okTitle: "띄우기", okAction: {
            let picker = UIColorPickerViewController()
            self.present(picker, animated: true)
        })
    }
    
    @IBAction func backgroundColorChanged(_ sender: UIButton) {
        showAlert(title: "배경색 변경", message: nil, okTitle: "버뀨가", okAction: {
            self.view.backgroundColor = .gray
        })
    }
    
    
}

extension ClosureViewController {
    func showAlert(title: String, message: String?, okTitle: String, okAction: @escaping () -> () ) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "cancel", style: .cancel)
        let ok = UIAlertAction(title: "ok", style: .default) { action in okAction() }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
