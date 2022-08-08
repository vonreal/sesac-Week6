//
//  KakaoBlogSearchAPIManger.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/08.
//

import Foundation

import Alamofire
import Kingfisher
import SwiftyJSON

class KakaoBlogSearchAPIManger {
    private init() {}
    
    static let shared = KakaoBlogSearchAPIManger()
    
    // Alamofire + SwityJSON
    // 검색 키워드
    // 인증키 in 헤더
    func callRequest(type: EndPoint, search: String, completionHandler: @escaping (JSON) -> ()) {
        guard let searchText = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = type.requestURL + searchText
        let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakao)"]
        
        AF.request(url, method: .get, headers: header).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json)
                
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
