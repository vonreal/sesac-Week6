//
//  contentListCollectionViewCell.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/10.
//

import UIKit

class ContentListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImageView.layer.cornerRadius = 10
        posterImageView.contentMode = .scaleAspectFill
    }
}
