//
//  SearchGifListEmptyView.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/26.
//

import UIKit

class SearchGifListEmptyView:  BaseEmptyView {
    override func attribute() {
        iconImageView.do {
            $0.setSFSymbols(systemName: "wind", weight: .bold)
        }
        guideLabel.do {
            $0.text == "검색 결과가 없습니다."
        }
    }
}
