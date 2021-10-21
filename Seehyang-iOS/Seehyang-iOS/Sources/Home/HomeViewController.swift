//
//  HomeViewController.swift
//  Seehyang-iOS
//
//  Created by Wody on 2021/10/17.
//

import UIKit
import Moya
import Kingfisher

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var todayPerfumeImageView: UIImageView!
    
    @IBOutlet weak var todayPerfumeLabel: UILabel!
    
    @IBOutlet weak var todayStoryCollectionView: UICollectionView!
    
    @IBOutlet weak var weeklyRankingCollectionView: UICollectionView!
    
    @IBOutlet weak var hotStoryCollectionView: UICollectionView!
    
    @IBOutlet weak var lovePerfumeCollectionView: UICollectionView!
    
    @IBOutlet weak var homeBannerView: UIView!
    
    @IBOutlet weak var refreshButtonImageView: UIImageView!
    
    @IBOutlet weak var moreButtonImageView: UIImageView!
    
    @IBOutlet weak var todayPerfumeCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var popularRankingCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var hotStoryCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lovePerfumeCollectionViewHeight: NSLayoutConstraint!
    
    var homeTodayStories: [HomeTodayStory] = [] {
        didSet { todayStoryCollectionView.reloadData() }
    }
    
    var homeWeeklyRankingPerfumes: [HomeWeeklyRankingPerfume] = [] {
        didSet { weeklyRankingCollectionView.reloadData() }
    }
    
    var homeHotStories: [HomeHotStoryDetail] = [] {
        didSet { hotStoryCollectionView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getHomeHotStory()
        getHomeTodayPerfume()
        getHomeWeeklyRanking()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        navigationItem.backBarButtonItem = backBarButtonItem
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = lovePerfumeCollectionView.collectionViewLayout
        lovePerfumeCollectionViewHeight.constant = layout.collectionViewContentSize.height
        self.view.layoutIfNeeded()
    }
    
    @IBAction func refreshTodayPerfume(_ sender: UIButton) {
        getHomeTodayPerfume()
    }
    
    @objc func refreshButtonImageViewPressed() {
        getHomeTodayPerfume()
    }
    
    @IBAction func moreButtonPressed(_ sender: UIButton) {
        gotoLovePerfumeListViewController()
    }
    
    @objc func moreButtonImageViewPressed() {
        gotoLovePerfumeListViewController()
    }
    
    /*  Description  :  List로 넘어가는 화면 전환 함수 */
    private func gotoLovePerfumeListViewController() {
        guard let list = self.storyboard?.instantiateViewController(withIdentifier: LovePerfumeListViewController.identifier) as? LovePerfumeListViewController else { return }
        
        navigationController?.pushViewController(list, animated: true)
    }
    
    /*  Description  :  오늘의 향수에 색깔 주는 함수 */
    private func colorTodayPerfume(_ name: String) {
        let attributedStr = NSMutableAttributedString(string: todayPerfumeLabel.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        attributedStr.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedStr.length))
        attributedStr.addAttribute(
            .foregroundColor,
            value: UIColor(named: "purple") ?? .black,
            range: ((todayPerfumeLabel.text ?? "") as NSString).range(of: "\(name)"))
        
        todayPerfumeLabel.attributedText = attributedStr
    }
    
    /*  Description  :  오늘의 향수 정보 UI 업데이트 */
    func updateTodayPerfume(_ todayPerfume: HomeTodayPerfume) {
        if let url = URL(string: Constants.S3URL + todayPerfume.thumbnail) {
            todayPerfumeImageView.kf.setImage(with: url)
        } else {
            todayPerfumeImageView.image = UIImage(named: Constants.testImageName)
        }

        todayPerfumeLabel.text = "\(todayPerfume.name)를\n눈으로 시향해 보세요."
        colorTodayPerfume(todayPerfume.name)
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
        setupMoreButtonImageView()
    }
    
    private func setupTodayPerfumeCollectionView() {
        todayStoryCollectionView.delegate = self
        todayStoryCollectionView.dataSource = self
        
        let width: CGFloat = ((view.bounds.width - 55) - 16) / 2
        let height: CGFloat = width * 134.0 / 156.0
        todayPerfumeCollectionViewHeight.constant = height
        view.layoutIfNeeded()
    }
    
    private func setupPopularRankingCollectionView() {
        weeklyRankingCollectionView.delegate = self
        weeklyRankingCollectionView.dataSource = self
        let width: CGFloat = ((view.bounds.width - 108) - 16) / 2
        let height: CGFloat = width * 196.0 / 130.0
        popularRankingCollectionViewHeight.constant = height
        view.layoutIfNeeded()
    }
    
    private func setupHotStoryCollectionView() {
        hotStoryCollectionView.delegate = self
        hotStoryCollectionView.dataSource = self
        let width: CGFloat = ((view.bounds.width - 55) - 16) / 2
        let height: CGFloat = width * 283.0 / 156.0
        hotStoryCollectionViewHeight.constant = height
        view.layoutIfNeeded()
    }
    
    private func setupLovePerfumeCollectionView() {
        lovePerfumeCollectionView.delegate = self
        lovePerfumeCollectionView.dataSource = self
    }
    
    private func setupHomeBannerView() {
        homeBannerView.layer.cornerRadius = 10
    }
    
    private func setupRefreshButtonImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(refreshButtonImageViewPressed))
        refreshButtonImageView.isUserInteractionEnabled = true
        refreshButtonImageView.addGestureRecognizer(tapGesture)
    }
    
    private func setupMoreButtonImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(moreButtonImageViewPressed))
        moreButtonImageView.isUserInteractionEnabled = true
        moreButtonImageView.addGestureRecognizer(tapGesture)
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case todayStoryCollectionView:
            return homeTodayStories.count
        case weeklyRankingCollectionView:
            return homeWeeklyRankingPerfumes.count
        case hotStoryCollectionView:
            return homeHotStories.count
        case lovePerfumeCollectionView:
            return 6
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case todayStoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayPerfumeCollectionViewCell.identifier, for: indexPath) as? TodayPerfumeCollectionViewCell else { return UICollectionViewCell() }
            cell.setupCells(homeTodayStories[indexPath.item])
            return cell
        case weeklyRankingCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularRankingCollectionViewCell.identifier, for: indexPath) as? PopularRankingCollectionViewCell else { return UICollectionViewCell() }
            cell.setupCells(homeWeeklyRankingPerfumes[indexPath.item], indexPath)
            return cell
        case hotStoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotStoryCollectionViewCell.identifier, for: indexPath) as? HotStoryCollectionViewCell else { return UICollectionViewCell() }
            cell.setupCells(homeHotStories[indexPath.item])
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
        case todayStoryCollectionView:
            return 8
        case weeklyRankingCollectionView:
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
        let collectionViewHeight: CGFloat = collectionView.bounds.height
        switch collectionView {
        case todayStoryCollectionView:
            let height = collectionViewHeight
            let width = height * 156.0 / 134.0
            return CGSize(width: width, height: height)
        case weeklyRankingCollectionView:
            let height = collectionViewHeight
            let width = height * 130.0 / 196.0
            return CGSize(width: width, height: height)
        case hotStoryCollectionView:
            let height = collectionViewHeight
            let width = height * 156.0 / 283.0
            return CGSize(width: width, height: height)
        case lovePerfumeCollectionView:
            let width: CGFloat = (collectionView.bounds.width - 63) / 2
            let height: CGFloat = width * 245.0 / 156.0
            return CGSize(width: width, height: height)
        default:
            return .zero
        }
    }
}
