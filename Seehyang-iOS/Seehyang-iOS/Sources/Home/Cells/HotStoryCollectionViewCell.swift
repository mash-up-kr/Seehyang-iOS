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
    
    @IBOutlet weak var perfumeNameLabel: UILabel!
    
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
    
    func setupCells(_ story: HomeHotStoryDetail) {
        
        if let url = URL(string: Constants.S3URL + "\(story.thumbnailURL)") {
            storyImageView.kf.setImage(with: url)
        }
        
        if let url = URL(string: Constants.S3URL + "\(story.perfumeImageURL)") {
            perfumeImageView.kf.setImage(with: url)
        }
        
        if let url = URL(string: Constants.S3URL + "\(story.userProfileImageURL)") {
            profileImageView.kf.setImage(with: url)
        }
        
        nickNameLabel.text = story.userNickname
        
        perfumeNameLabel.text = "이거 서버에서 안 내려옵니다! 알려드려야함!!"
        
        likesCountLabel.text = "20000 이것두.."
    }
    
}
