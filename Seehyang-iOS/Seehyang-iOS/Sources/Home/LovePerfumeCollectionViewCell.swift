//
//  LovePerfumeCollectionViewCell.swift
//  Seehyang-iOS
//
//  Created by Wody on 2021/10/20.
//

import UIKit

class LovePerfumeCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "LovePerfumeCollectionViewCell"
    @IBOutlet weak var perfumeImageView: UIImageView!
    @IBOutlet weak var perfumeBrandLabel: UILabel!
    @IBOutlet weak var perfumeNameLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
}
