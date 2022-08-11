//
//  NAFILXMainViewController.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/10.
//

import UIKit

import Kingfisher

/*
 [27회차 과제]
 - 테이블 뷰 => 프로토콜로 확장하기 ✅
    - 테이블 뷰 셀
        (1) 레이블 (비슷한 콘텐츠 및 장르 추천)
        (2) 콜렉션 뷰, 수평 스크롤 ✅
            (2-1) 콜렉션 뷰 셀 => 프로토콜로 확장하기, 셀 파일 생성해서 아울렛 연결하기 ✅
                (2-1-1) 이미지 뷰 ✅
 */

class NAFILXMainViewController: UIViewController {
    
    @IBOutlet weak var movieContentTableView: UITableView!
    
    var movieList = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designUI()
        tableViewDelegate()
        
        TMDBAPIManager.shared.requestMovieImage { movieList in
            self.movieList = movieList
            DispatchQueue.main.sync {
                dump(movieList)
                self.movieContentTableView.reloadData()
            }
        }
    }
    
    func designUI() {
        view.backgroundColor = .black
        movieContentTableView.backgroundColor = .clear
    }
    
    func tableViewDelegate() {
        movieContentTableView.delegate = self
        movieContentTableView.dataSource = self
    }
}

extension NAFILXMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 섹션의 수 = 장르 및 콘텐츠의 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    // 셀
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 테이블 셀 만들어서 관리하기
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieContentTableViewCell.reuseIdentifier, for: indexPath) as? MovieContentTableViewCell else { return UITableViewCell() }
        
        cell.contentListCollectionView.delegate = self
        cell.contentListCollectionView.dataSource = self
        cell.contentListCollectionView.backgroundColor = .clear
        cell.contentListCollectionView.tag = indexPath.row
        
        cell.genreLabel.text = "\(TMDBAPIManager.shared.movieList[indexPath.row].0) 비슷한 콘텐츠"
        cell.genreLabel.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }
    
}

extension NAFILXMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag <= movieList.count {
            return movieList[collectionView.tag].count
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentListCollectionViewCell.reuseIdentifier, for: indexPath) as? ContentListCollectionViewCell else { return UICollectionViewCell() }
        
        cell.posterImageView.backgroundColor = .yellow
        if !movieList[collectionView.tag].isEmpty {
            if indexPath.item <= movieList[collectionView.tag].count {
                let url = TMDBAPIManager.shared.imageURL + movieList[collectionView.tag][indexPath.item]
                cell.posterImageView.kf.setImage(with: URL(string: url))
            }
        }
        
        return cell
    }
    
    
}
