//
//  CardCollectionViewCell.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/09.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    func setupUI() {
        cardView.posterImageView.backgroundColor = .white
        cardView.posterImageView.layer.borderColor = UIColor.lightGray.cgColor
        cardView.posterImageView.layer.borderWidth = 1
        
        cardView.likeButton.tintColor = .systemPink
    }
}
