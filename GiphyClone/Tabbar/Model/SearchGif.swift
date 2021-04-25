//
//  SearchGif.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import Foundation

struct SearchGif: Codable {
    let id: String?
    let user: User?
    let images: Images?

    enum CodingKeys: String, CodingKey {
        case id
        case user
        case images
    }
}

// MARK: - User
struct User: Codable {
    let avatarURL: String?
    let bannerURL: String?
    let profileURL: String?
    let userName: String?
    let displayName: String?
    let description: String?
    let instagramURL: String?
    let isVerified: Bool?

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case bannerURL = "banner_url"
        case profileURL = "profile_url"
        case displayName = "display_name"
        case instagramURL = "instagram_url"
        case isVerified = "is_verified"
        case userName = "username"
        case description
        
    }
}

// MARK: - Images
struct Images: Codable {
    let originalStill: The480_WStill?

    enum CodingKeys: String, CodingKey {
        case originalStill = "original_still"
    }
}

// MARK: - The480_WStill
struct The480_WStill: Codable {
    let height, width: String?
    let url: String?
    let size: String?
}
