//
//  EmptyViewType.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/26.
//

import UIKit

enum EptyViewType {
    case SearchGifListEmptyViewType
    
    var view: UIView {
        switch self {
        case .SearchGifListEmptyViewType:
            return UIView()
        }
    }
}

