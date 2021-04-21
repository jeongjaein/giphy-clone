//
//  ImageCacheManager.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class ImageCacheManager {
    
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
