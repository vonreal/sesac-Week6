//
//  CardView.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/09.
//

import UIKit

/*
    Xml Interface Builder
    1. UIView CUstom class
    2. File's owner > 활용도 / 여러 View 제약
 */

/*
 View:
  - 인터페이스 빌더 UI 초기화 구문: required init?
        - 프로토콜 초기화 구문: required > 초기화 구문이 프로토콜로 명세되어 있음
  - 코드 UI 초기화 구문: override init
 */

protocol A {
    func example()
    init()
}

class CardView: UIView {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        view.backgroundColor = .lightGray
        self.addSubview(view)
    }
}
