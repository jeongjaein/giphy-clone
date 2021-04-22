//
//  RandomID.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/22.
//

import Foundation

struct RandomID: Codable {
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id = "random_id"
    }
}
