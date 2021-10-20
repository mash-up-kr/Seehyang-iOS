//
//  HomeViewController.swift
//  Seehyang-iOS
//
//  Created by Wody on 2021/10/17.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var todayPerfumeImageView: UIImageView!
    @IBOutlet weak var todayPerfumeLabel: UILabel!
    @IBOutlet weak var todayPerfumeCollectionView: UICollectionView!
    @IBOutlet weak var popularRankingCollectionView: UICollectionView!
    @IBOutlet weak var hotStoryCollectionView: UICollectionView!
    @IBOutlet weak var lovePerfumeCollectionView: UICollectionView!
    @IBOutlet weak var homeBannerView: UIView!
    
    @IBOutlet weak var lovePerfumeCollectionViewHeight: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lovePerfumeCollectionViewHeight.constant = lovePerfumeCollectionView.collectionViewLayout.collectionViewContentSize.height
        print(lovePerfumeCollectionViewHeight.constant)
        
        self.view.layoutIfNeeded()
    }
}

// MARK: setup

extension HomeViewController {
    
    private func setupViews() {
        setupTodayPerfumeCollectionView()
        setupPopularRankingCollectionView()
        setupHotStoryCollectionView()
        setupLovePerfumeCollectionView()
        setupHomeBannerView()
    }
    
    private func setupTodayPerfumeCollectionView() {
        todayPerfumeCollectionView.delegate = self
        todayPerfumeCollectionView.dataSource = self
    }
    
    private func setupPopularRankingCollectionView() {
        popularRankingCollectionView.delegate = self
        popularRankingCollectionView.dataSource = self
    }
    
    private func setupHotStoryCollectionView() {
        hotStoryCollectionView.delegate = self
        hotStoryCollectionView.dataSource = self
    }
    
    private func setupLovePerfumeCollectionView() {
        lovePerfumeCollectionView.delegate = self
        lovePerfumeCollectionView.dataSource = self
    }
    
    private func setupHomeBannerView() {
        homeBannerView.layer.cornerRadius = 10
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case todayPerfumeCollectionView:
            return 10
        case popularRankingCollectionView:
            return 10
        case hotStoryCollectionView:
            return 10
        case lovePerfumeCollectionView:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case todayPerfumeCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayPerfumeCollectionViewCell.identifier, for: indexPath) as? TodayPerfumeCollectionViewCell else { return UICollectionViewCell() }
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            return cell
        case popularRankingCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularRankingCollectionViewCell.identifier, for: indexPath) as? PopularRankingCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        case hotStoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotStoryCollectionViewCell.identifier, for: indexPath) as? HotStoryCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        case lovePerfumeCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LovePerfumeCollectionViewCell.identifier, for: indexPath) as? LovePerfumeCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        default: // 아무거나 집어넣음
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayPerfumeCollectionViewCell.identifier, for: indexPath) as? TodayPerfumeCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case todayPerfumeCollectionView:
            return 8
        case popularRankingCollectionView:
            return 8
        case hotStoryCollectionView:
            return 8
        case lovePerfumeCollectionView:
            return 15
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth: CGFloat = collectionView.bounds.width
        let collectionViewHeight: CGFloat = collectionView.bounds.height
        switch collectionView {
        case todayPerfumeCollectionView:
            let height = collectionViewHeight
            let width = height * 156.0 / 134.0
            return CGSize(width: width, height: height)
        case popularRankingCollectionView:
            let height = collectionViewHeight
            let width = height * 130.0 / 196.0
            return CGSize(width: width, height: height)
        case hotStoryCollectionView:
            let height = collectionViewHeight
            let width = height * 156.0 / 283.0
            return CGSize(width: width, height: height)
        case lovePerfumeCollectionView:
            let width: CGFloat = (collectionViewWidth - 48 - 15) / 2
            let height: CGFloat = width * 245.0 / 156.0
            return CGSize(width: width, height: height)
        default:
            return .zero
        }
    }
}
