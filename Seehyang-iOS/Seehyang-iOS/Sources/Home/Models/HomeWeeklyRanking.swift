//
//  HomeWeeklyRanking.swift
//  Seehyang-iOS
//
//  Created by Wody on 2021/10/22.
//

import Foundation

struct HomeWeeklyRanking: Codable {
    let perfumes: [HomeWeeklyRankingPerfume]
}

struct HomeWeeklyRankingPerfume: Codable {
    let rank, id: Int
    let perfumeImageURL, brandName, perfumeName: String

    enum CodingKeys: String, CodingKey {
        case rank, id
        case perfumeImageURL = "perfumeImageUrl"
        case brandName, perfumeName
    }
}
