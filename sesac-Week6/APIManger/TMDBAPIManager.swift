//
//  TMDBAPIManager.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/10.
//

import Foundation

import Alamofire
import Kingfisher
import SwiftyJSON
/*
 TMDB API
 https://developers.themoviedb.org/3/tv-seasons/get-tv-season-details
 */

class TMDBAPIManager {
    private init() {}
    
    static let shared = TMDBAPIManager()
    
    let tvList = [
        ("환혼", 135157),
        ("이상한 변호사 우영우", 197067),
        ("인사이더", 135655),
        ("미스터 션사인", 75820),
        ("스카이 캐슬", 84327),
        ("사랑의 불시착", 94796),
        ("이태원 클라스", 96162),
        ("호텔 델루나", 90447)
    ]
    
    let movieList = [
        ("그레이맨과", 725201),
        ("미니언즈2와", 438148),
        ("해리포터와 불의 잔과", 674),
        ("수퍼 소닉2와", 675353),
        ("버즈 라이트이어와", 718789),
        ("엑소시즘 오브 갓과", 836225)
    ]
    
    let imageURL = "https://image.tmdb.org/t/p/w500"
    let seasonURL = "https://api.themoviedb.org/3/tv/135157/season/1?api_key=\(APIKey.tmdb)&language=ko-KR"
    
    func callMovieRequest(query: Int, completionHandler: @escaping ([String]) -> ()) {
        let url = "https://api.themoviedb.org/3/movie/\(query)/recommendations?api_key=\(APIKey.tmdb)&language=ko-KR&page=1"
        
        AF.request(url, method: .get).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                let stillPaths = json["results"].arrayValue.map { $0["poster_path"].stringValue }.filter { !$0.isEmpty }
                
                
                completionHandler(stillPaths)
                
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func requestMovieImage(completionHandler: @escaping ([[String]]) -> ()) {

        var posterList: [[String]] = []

        TMDBAPIManager.shared.callMovieRequest(query: movieList[0].1) { value in
            posterList.append(value)

            TMDBAPIManager.shared.callMovieRequest(query: self.movieList[1].1) { value in
                posterList.append(value)

                TMDBAPIManager.shared.callMovieRequest(query: self.movieList[2].1) { value in
                    posterList.append(value)

                    TMDBAPIManager.shared.callMovieRequest(query: self.movieList[3].1) { value in
                        posterList.append(value)

                        TMDBAPIManager.shared.callMovieRequest(query: self.movieList[4].1) { value in
                            posterList.append(value)

                            TMDBAPIManager.shared.callMovieRequest(query: self.movieList[5].1) { value in
                                posterList.append(value)
                                completionHandler(posterList)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func callRequest(query: Int, completionHandler: @escaping ([String]) -> ()) {
        let url = "https://api.themoviedb.org/3/tv/\(query)/season/1?api_key=\(APIKey.tmdb)&language=ko-KR"
        
        AF.request(url, method: .get).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                let stillPaths = json["episodes"].arrayValue.map { $0["still_path"].stringValue }
            
                completionHandler(stillPaths)
                
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func requestImage(completionHandler: @escaping ([[String]]) -> ()) {

        var posterList: [[String]] = []

        TMDBAPIManager.shared.callRequest(query: tvList[0].1) { value in
            posterList.append(value)

            TMDBAPIManager.shared.callRequest(query: self.tvList[1].1) { value in
                posterList.append(value)

                TMDBAPIManager.shared.callRequest(query: self.tvList[2].1) { value in
                    posterList.append(value)

                    TMDBAPIManager.shared.callRequest(query: self.tvList[3].1) { value in
                        posterList.append(value)

                        TMDBAPIManager.shared.callRequest(query: self.tvList[4].1) { value in
                            posterList.append(value)

                            TMDBAPIManager.shared.callRequest(query: self.tvList[5].1) { value in
                                posterList.append(value)

                                TMDBAPIManager.shared.callRequest(query: self.tvList[6].1) { value in
                                    posterList.append(value)

                                    TMDBAPIManager.shared.callRequest(query: self.tvList[7].1) { value in
                                        posterList.append(value)
                                        completionHandler(posterList)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    func requestEpisodeImage() {
        
        // 반복문으로 구현하면 어떤 문제가 생길까?
        // 1. 순서 보장 x, 2. 언제 끝날 지 모름 3. limit(ex 1초 5번 block)
        
    }
}
