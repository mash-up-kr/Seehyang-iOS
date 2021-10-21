//
//  HomeViewController.swift
//  Seehyang-iOS
//
//  Created by Wody on 2021/10/17.
//

import UIKit
import Moya

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var todayPerfumeImageView: UIImageView!
    
    @IBOutlet weak var todayPerfumeLabel: UILabel!
    
    @IBOutlet weak var todayPerfumeCollectionView: UICollectionView!
    
    @IBOutlet weak var popularRankingCollectionView: UICollectionView!
    
    @IBOutlet weak var hotStoryCollectionView: UICollectionView!
    
    @IBOutlet weak var lovePerfumeCollectionView: UICollectionView!
    
    @IBOutlet weak var homeBannerView: UIView!
    
    @IBOutlet weak var refreshButtonImageView: UIImageView!
    
    @IBOutlet weak var moreButtonImageView: UIImageView!
    
    @IBOutlet weak var todayPerfumeCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var popularRankingCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var hotStoryCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lovePerfumeCollectionViewHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        colorTodayPerfume("톰포드 네롤리 포르토피노")
        getHomeHotStory()
        getHomeTodayData()
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
        
    }
    
    @objc func refreshButtonImageViewPressed() {
        
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
    
    /*  Description  :  오늘의 향수 정보 API 통신 */
    private func getHomeTodayData() {
        NetworkProvider.shared.requestHomeToday { result in
            switch result {
            case .success(let data):
                if let data = data.data {
                    print(data.perfume)
                    print(data.stories)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /*  Description  :  오늘의 향수 핫한 스토리 API 통신 */
    private func getHomeHotStory() {
        NetworkProvider.shared.requestHomeHotStory { result in
            switch result {
            case .success(let data):
                if let data = data.data {
                    print(data.stories)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /*  Description  :  오늘의 향수 주간 랭킹 API 통신 */
    private func getHomeWeeklyRanking() {
        NetworkProvider.shared.requestHomeWeeklyRanking { result in
            switch result {
            case .success(let data):
                if let data = data.data {
                    print(data.perfumes)
                }
            case .failure(let error):
                print(error)
            }
        }
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
        
        let width: CGFloat = ((view.bounds.width - 55) - 16) / 2
        let height: CGFloat = width * 134.0 / 156.0
        todayPerfumeCollectionViewHeight.constant = height
        view.layoutIfNeeded()
    }
    
    private func setupPopularRankingCollectionView() {
        popularRankingCollectionView.delegate = self
        popularRankingCollectionView.dataSource = self
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
        case todayPerfumeCollectionView:
            return 10
        case popularRankingCollectionView:
            return 10
        case hotStoryCollectionView:
            return 10
        case lovePerfumeCollectionView:
            return 6
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
            let width: CGFloat = (collectionView.bounds.width - 63) / 2
            let height: CGFloat = width * 245.0 / 156.0
            return CGSize(width: width, height: height)
        default:
            return .zero
        }
    }
}
