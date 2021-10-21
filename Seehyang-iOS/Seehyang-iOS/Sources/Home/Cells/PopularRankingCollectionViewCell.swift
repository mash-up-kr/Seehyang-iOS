//
//  PopularRankingCollectionViewCell.swift
//  Seehyang-iOS
//
//  Created by Wody on 2021/10/20.
//

import UIKit

class PopularRankingCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "PopularRankingCollectionViewCell"
    
    @IBOutlet weak var perfumeWrapperView: UIView!
    @IBOutlet weak var perfumeImageView: UIImageView!
    @IBOutlet weak var rankingWrapperView: UIView!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var perfumeBrandLabel: UILabel!
    @IBOutlet weak var perfumeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rankingWrapperView.layer.cornerRadius = 4
        perfumeWrapperView.layer.cornerRadius = 10
        perfumeWrapperView.layer.masksToBounds = true
    }
}
