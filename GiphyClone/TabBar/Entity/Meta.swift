//
//  Meta.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import Foundation

struct Meta: Codable {
    let status: Int
    let msg, responseID: String

    enum CodingKeys: String, CodingKey {
        case status, msg
        case responseID = "response_id"
    }
}
