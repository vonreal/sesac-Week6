//
//  SeSACButton.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/09.
//

import UIKit

/*
 Swift Attribute: @Inspectable, @IBDesignable, @objc, @escaping, @available, @discardableResult etc.
 */

// 인터페이스 빌더 컴파일 시점 실시간으로 객체 속성을 확인할 수 있음
@IBDesignable class SeSACButton: UIButton {
    
    // 인터페이스 빌더 인스펙터 영역 Show
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
}
