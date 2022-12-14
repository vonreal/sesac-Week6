//
//  MainTableViewCell.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/09.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    // 얘도 delegate와 datasource가 필요함 -> mainViewController에서 요청
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("MainTableViewCell", #function)
        setupUI()
    }
    
    func setupUI() {
        titleLabel.text = "넷플릭스 인기 콘텐츠"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.backgroundColor = .clear
        
//        contentCollectionView.backgroundColor = .clear
        contentCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 190)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
}
