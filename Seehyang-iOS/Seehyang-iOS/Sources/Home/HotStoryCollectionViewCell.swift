//
//  HotStoryCollectionViewCell.swift
//  Seehyang-iOS
//
//  Created by Wody on 2021/10/20.
//

import UIKit

class HotStoryCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "HotStoryCollectionViewCell"
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var perfumeImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 1.0
        
        perfumeImageView.layer.cornerRadius = perfumeImageView.bounds.height / 2
        perfumeImageView.layer.masksToBounds = true
        storyImageView.layer.cornerRadius = 8.0
    }
    
}
