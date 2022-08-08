//
//  URL+Extension.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/08.
//

import Foundation

extension URL {
    static let kakaoSearchBaseURL = "https://dapi.kakao.com/v2/search/"
    
    static func makeEndPointString(_ endPoint: String) -> String {
        return kakaoSearchBaseURL + endPoint
    }
}
