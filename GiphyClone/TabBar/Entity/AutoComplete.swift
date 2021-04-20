//
//  AutoComplete.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import Foundation

// MARK: - Welcome
struct AutoComplete: Codable {
    let data: [Datum]
    let pagination: Pagination
    let meta: Meta
}

// MARK: - Datum
struct Datum: Codable {
    let name, analyticsResponsePayload: String

    enum CodingKeys: String, CodingKey {
        case name
        case analyticsResponsePayload = "analytics_response_payload"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let status: Int
    let msg, responseID: String

    enum CodingKeys: String, CodingKey {
        case status, msg
        case responseID = "response_id"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let count, offset: Int
}
