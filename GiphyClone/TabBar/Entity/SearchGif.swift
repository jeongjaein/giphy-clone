//
//  SearchGif.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import Foundation

// MARK: - SearchGif
struct SearchGif: Codable {
    let type: String?
    let id: String?
    let url: String?
    let slug: String?
    let bitlyURL: String?
    let bitlyGIFURL: String?
    let embedURL: String?
    let username: String?
    let source: String?
    let rating: String?
    let contentURL: String?
    let user: User?
    let sourceTLD: String?
    let sourcePostURL: String?
    let images: Images?
    let title: String?
    let importDatetime: String?
    let trendingDatetime: String?
    let updateDateTime: String?
    let createDataTime: String?
    
    let isSticker: Int?
    let analyticsResponsePayload: String?
    let analytics: Analytics?

    enum CodingKeys: String, CodingKey {
        case type, id, url, slug
        case bitlyGIFURL = "bitly_gif_url"
        case bitlyURL = "bitly_url"
        case embedURL = "embed_url"
        case username, source, title, rating
        case contentURL = "content_url"
        case sourceTLD = "source_tld"
        case sourcePostURL = "source_post_url"
        case isSticker = "is_sticker"
        case updateDateTime = "update_datetime"
        case createDataTime = "create_datetime"
        case importDatetime = "import_datetime"
        case trendingDatetime = "trending_datetime"
        case images, user
        case analyticsResponsePayload = "analytics_response_payload"
        case analytics
    }
}

// MARK: - Analytics
struct Analytics: Codable {
    let onload, onclick, onsent: Onclick
}

// MARK: - Onclick
struct Onclick: Codable {
    let url: String?
}

// MARK: - Images
struct Images: Codable {
    let original: FixedHeight?
    let downsized, downsizedLarge, downsizedMedium: The480_WStill?
    let downsizedSmall: DownsizedSmall?
    let downsizedStill: The480_WStill?
    let fixedHeight, fixedHeightDownsampled, fixedHeightSmall: FixedHeight?
    let fixedHeightSmallStill, fixedHeightStill: The480_WStill?
    let fixedWidth, fixedWidthDownsampled, fixedWidthSmall: FixedHeight?
    let fixedWidthSmallStill, fixedWidthStill: The480_WStill?
    let looping: Looping?
    let originalStill: The480_WStill?
    let originalMp4, preview: DownsizedSmall?
    let previewGIF, previewWebp: The480_WStill?
    let hd: DownsizedSmall?
    let the480WStill: The480_WStill?

    enum CodingKeys: String, CodingKey {
        case original, downsized
        case downsizedLarge = "downsized_large"
        case downsizedMedium = "downsized_medium"
        case downsizedSmall = "downsized_small"
        case downsizedStill = "downsized_still"
        case fixedHeight = "fixed_height"
        case fixedHeightDownsampled = "fixed_height_downsampled"
        case fixedHeightSmall = "fixed_height_small"
        case fixedHeightSmallStill = "fixed_height_small_still"
        case fixedHeightStill = "fixed_height_still"
        case fixedWidth = "fixed_width"
        case fixedWidthDownsampled = "fixed_width_downsampled"
        case fixedWidthSmall = "fixed_width_small"
        case fixedWidthSmallStill = "fixed_width_small_still"
        case fixedWidthStill = "fixed_width_still"
        case looping
        case originalStill = "original_still"
        case originalMp4 = "original_mp4"
        case preview
        case previewGIF = "preview_gif"
        case previewWebp = "preview_webp"
        case hd
        case the480WStill = "480w_still"
    }
}

// MARK: - The480_WStill
struct The480_WStill: Codable {
    let height, width: String?
    let url: String?
    let size: String?
}

// MARK: - DownsizedSmall
struct DownsizedSmall: Codable {
    let height, width, mp4Size: String?
    let mp4: String?

    enum CodingKeys: String, CodingKey {
        case height, width
        case mp4Size = "mp4_size"
        case mp4
    }
}

// MARK: - FixedHeight
struct FixedHeight: Codable {
    let url: String?
    let width: String?
    let height: String?
    let size: String?
    let mp4: String?
    let mp4Size: String?
    let webp: String?
    let webpSize: String?
    
    let frames: String?
    let hash: String?

    enum CodingKeys: String, CodingKey {
        case height, width, size, url
        case mp4Size = "mp4_size"
        case mp4
        case webpSize = "webp_size"
        case webp, frames, hash
    }
}

// MARK: - Looping
struct Looping: Codable {
    let mp4Size: String?
    let mp4: String?

    enum CodingKeys: String, CodingKey {
        case mp4Size = "mp4_size"
        case mp4
    }
}

// MARK: - User
struct User: Codable {
    let avatarURL: String?
    let bannerURL: String?
    let profileURL: String?
    let userName: String?
    let displayName: String?

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case bannerURL = "banner_url"
        case profileURL = "profile_url"
        case displayName = "display_name"
        case userName
    }
}
