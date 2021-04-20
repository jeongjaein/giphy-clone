//
//  BaseResponse.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let data: T
    let pagination: Pagination
    let meta: Meta
}
