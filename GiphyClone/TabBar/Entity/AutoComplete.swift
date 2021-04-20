//
//  AutoComplete.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import Foundation

// MARK: - AutoComplete
struct AutoComplete: Codable {
    let name, analyticsResponsePayload: String

    enum CodingKeys: String, CodingKey {
        case name
        case analyticsResponsePayload = "analytics_response_payload"
    }
}


