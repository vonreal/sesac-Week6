//
//  movieContentTableViewCell.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/10.
//

import UIKit

class MovieContentTableViewCell: UITableViewCell {

    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var contentListCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentListCollectionView.collectionViewLayout = collectionViewLayout()
        
        designUI()
    }
    
    func designUI() {
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        genreLabel.textColor = .white
        genreLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 110, height: 180)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        
        return layout
    }
    

}
