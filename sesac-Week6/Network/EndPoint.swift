//
//  EndPoint.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/08.
//

import Foundation

enum EndPoint {
    case blog
    case cafe
    
    // 저장 프로퍼티를 못쓰는 이유: 인스턴스 생성 불가
    // 연산 프로퍼티를 쓸 수 있는 이유: 메서드처럼 작동 (메모리에 올라가는 영역이 다름)
    var requestURL: String {
        switch self {
        case .blog:
            return URL.makeEndPointString("blog?query=")
        case .cafe:
            return URL.makeEndPointString("cafe?query=")
        }
    }
}
