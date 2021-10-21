//
//  HomeToday.swift
//  Seehyang-iOS
//
//  Created by Wody on 2021/10/22.
//

import Foundation

struct HomeToday: Codable {
    let perfume: HomeTodayPerfume
    let stories: [HomeTodayStory]
}

struct HomeTodayPerfume: Codable {
    let id: Int
    let thumbnail, name: String
}

struct HomeTodayStory: Codable {
    let id: Int
    let imageURL: String
    let userProfileImage: String
    let userNickname: String
    let likeCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case userProfileImage, userNickname, likeCount
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(Int.self, forKey: .id)) ?? -1
        imageURL = (try? values.decode(String.self, forKey: .imageURL)) ?? ""
        userProfileImage = (try? values.decode(String.self, forKey: .userProfileImage)) ?? ""
        userNickname = (try? values.decode(String.self, forKey: .userNickname)) ?? ""
        likeCount = (try? values.decode(Int.self, forKey: .likeCount)) ?? -1
    }
}
