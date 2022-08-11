//
//  MainViewController.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/09.
//

import UIKit

import Kingfisher

/*
    tableView - CollectionVIew > 프로토콜
    tag
 
    awakeFromNib - 셀 UI 초기화, 재사용 매커니즘에 의해 일정 횟수 이상 호출되지 않음.
    cellForItemAt - 재사용 될 때마다, 사용자에게 보여질 때마다 항상 실행됨.
 */

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    let numberList: [[Int]] = [[Int](100...110),
                               [Int](55...75),
                               [Int](234...567)]
    
    var episodeList: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self

        // Do any additional setup after loading the view.
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        bannerCollectionView.collectionViewLayout = collectionViewLayout()
        bannerCollectionView.isPagingEnabled = true
        
        TMDBAPIManager.shared.requestImage { value in
            dump(value)
            
            self.episodeList = value
            DispatchQueue.main.sync {
                self.mainTableView.reloadData()
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return episodeList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // 내부 매개변수 tableView를 통해 테이블뷰를 특정
    // 테이블뷰 객체가 하나 일 경우에는 내부 매개변수를 활용하지 않아도 문제가 생기지 않는다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = "\(TMDBAPIManager.shared.tvList[indexPath.section].0) 드라마 다시보기"
        print("MainViewController", #function, indexPath)
        cell.backgroundColor = .yellow
        cell.contentCollectionView.backgroundColor = .clear
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.tag = indexPath.section
        cell.contentCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        cell.contentCollectionView.reloadData() // index out of range 문제 해결
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
}

// 하나의 프로토콜, 메서드에서 여러 컬렉션뷰의 delegate, datasource 구현해야함
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    // 현재 콜렉션 뷰는 2개이기 때문에 bannerCollectionView || 테이블 뷰 안에 있는 컬렉션뷰가 들어올 수 있다.
    // 내부 매개변수가 아닌 명확한 아웃렛을 사용할 경우, 셀이 재사용 되면 특정 collectionView 셀을 재사용하게 될 수 있음
    // ex guard let cell = bannerCollectionView.dequeueReusableCell(~)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell() }
        
        
        if collectionView == bannerCollectionView {
            let color: [UIColor] = [.purple,.black,.lightGray,.gray]
            cell.cardView.posterImageView.backgroundColor = color.randomElement()
        } else {
            let url = URL(string: "\(TMDBAPIManager.shared.imageURL)\(episodeList[collectionView.tag][indexPath.item])")
            cell.cardView.posterImageView.kf.setImage(with: url)
            cell.cardView.posterImageView.contentMode = .scaleAspectFill
            cell.cardView.label.text = nil
            
            //            cell.cardView.posterImageView.backgroundColor = collectionView.tag.isMultiple(of: 2) ? .brown : .purple
            
//            if indexPath.item < 2 {
//            cell.cardView.label.text = String(numberList[collectionView.tag % 3][indexPath.item])
//            }
        }
        return cell
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: bannerCollectionView.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
}
