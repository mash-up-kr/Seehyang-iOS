//
//  HomeHotStory.swift
//  Seehyang-iOS
//
//  Created by Wody on 2021/10/22.
//

import Foundation

struct HomeHotStory: Codable {
    let stories: [HomeHotStoryStory]
}

// MARK: - Story
struct HomeHotStoryStory: Codable {
    let id: Int
    let perfumeImageURL, thumbnailURL: String
    let userProfileImageURL: String
    let userNickname: String

    enum CodingKeys: String, CodingKey {
        case id
        case perfumeImageURL = "perfumeImageUrl"
        case thumbnailURL = "thumbnailUrl"
        case userProfileImageURL = "userProfileImageUrl"
        case userNickname
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(Int.self, forKey: .id)) ?? -1
        perfumeImageURL = (try? values.decode(String.self, forKey: .perfumeImageURL)) ?? ""
        thumbnailURL = (try? values.decode(String.self, forKey: .thumbnailURL)) ?? ""
        userProfileImageURL = (try? values.decode(String.self, forKey: .userProfileImageURL)) ?? ""
        userNickname = (try? values.decode(String.self, forKey: .userNickname)) ?? ""
    }
}
