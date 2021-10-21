//
//  LovePerfumeListViewController.swift
//  Seehyang-iOS
//
//  Created by Wody on 2021/10/22.
//

import UIKit

class LovePerfumeListViewController: UIViewController {
    static let identifier: String = "LovePerfumeListViewController"

    @IBOutlet weak var lovePerfumeCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
}

// MARK: setup

extension LovePerfumeListViewController {
    
    private func setupViews() {
        setupView()
        setupLovePerfumeCollectionView()
    }
    
    private func setupView() {
        self.title = "꾸준히 사랑받는 향수"
    }
    
    private func setupLovePerfumeCollectionView() {
        lovePerfumeCollectionView.delegate = self
        lovePerfumeCollectionView.dataSource = self
    }
}

extension LovePerfumeListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LovePerfumeCollectionViewCell.identifier, for: indexPath) as? LovePerfumeCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.bounds.width - 63) / 2
        let height: CGFloat = width * 245.0 / 156.0
        return CGSize(width: width, height: height)
    }
}
