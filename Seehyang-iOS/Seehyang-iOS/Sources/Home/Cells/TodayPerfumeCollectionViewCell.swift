//
//  TodayPerfumeCollectionViewCell.swift
//  Seehyang-iOS
//
//  Created by Wody on 2021/10/17.
//

import UIKit

class TodayPerfumeCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "TodayPerfumeCollectionViewCell"
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 1.0
    }
    
    func setupCells(_ story: HomeTodayStory) {
        if let url = URL(string: Constants.S3URL + "\(story.imageURL)") {
            print(url)
            storyImageView.kf.setImage(with: url)
        }
        
        if let url = URL(string: Constants.S3URL + "\(story.userProfileImage)") {
            profileImageView.kf.setImage(with: url)
        }
        
        nickNameLabel.text = story.userNickname
    }
    
}
