//
//  AppColor.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/23.
//

import UIKit

enum AppColor {
    case searchTextField
    case leftButton
    case centerButton
    case rightButton
    case searchButton
    case likeButton
    case topTab
    case clock
    case recentSearches
    case arrow
    
    var value: UIColor {
        switch self {
        case .searchTextField:
            return #colorLiteral(red: 0.9960784314, green: 1, blue: 0.9960784314, alpha: 1)
        case .leftButton:
            return #colorLiteral(red: 0.5176470588, green: 0.2470588235, blue: 0.9960784314, alpha: 1)
        case .centerButton:
            return #colorLiteral(red: 0, green: 0.8588235294, blue: 0.6980392157, alpha: 1)
        case .rightButton:
            return #colorLiteral(red: 0.9333333333, green: 0.3176470588, blue: 0.5725490196, alpha: 1)
        case .clock:
            return #colorLiteral(red: 1, green: 0.9529411765, blue: 0.3607843137, alpha: 1)
        case .searchButton:
            return #colorLiteral(red: 0.831372549, green: 0.1176470588, blue: 0.8235294118, alpha: 1)
        case .likeButton:
            return #colorLiteral(red: 1, green: 0.4, blue: 0.4, alpha: 1)
        case .topTab:
            return #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
        case .recentSearches:
            return #colorLiteral(red: 0.1803921569, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
        case .arrow:
            return #colorLiteral(red: 0, green: 0.7960784314, blue: 0.9960784314, alpha: 1)
        }
    }
}

