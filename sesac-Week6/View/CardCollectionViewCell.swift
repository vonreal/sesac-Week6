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

    override func prepareForReuse() {
        super.prepareForReuse()
        
        cardView.label.text = nil
    }
    
    func setupUI() {
        cardView.posterImageView.backgroundColor = .clear
        
        cardView.likeButton.tintColor = .systemPink
    }
}
