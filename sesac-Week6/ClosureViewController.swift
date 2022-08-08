//
//  ClosureViewController.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/08.
//

import UIKit

class ClosureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
