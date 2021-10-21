//
//  HomeService.swift
//  Seehyang-iOS
//
//  Created by Wody on 2021/10/22.
//

import Foundation

extension HomeViewController {
    
    /*  Description  :  오늘의 향수 정보 API 통신 */
    func getHomeTodayPerfume() {
        NetworkProvider.shared.requestHomeToday { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if let data = data.data {
                    self.updateTodayPerfume(data.perfume)
                    self.homeTodayStories = data.stories
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /*  Description  :  오늘의 향수 핫한 스토리 API 통신 */
    func getHomeHotStory() {
        NetworkProvider.shared.requestHomeHotStory { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if let data = data.data {
                    self.homeHotStories = data.stories
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /*  Description  :  오늘의 향수 주간 랭킹 API 통신 */
    func getHomeWeeklyRanking() {
        NetworkProvider.shared.requestHomeWeeklyRanking { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if let data = data.data {
                    self.homeWeeklyRankingPerfumes = data.perfumes
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
