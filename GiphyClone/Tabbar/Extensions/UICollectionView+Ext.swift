//
//  UICollectionView+Ext.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/26.
//

import UIKit

extension UICollectionView {
    func setEmptyView(type: EmptyViewType) {
        type.view.frame = CGRect(x: self.center.x,
                                 y: self.center.y,
                                 width: self.bounds.size.width,
                                 height: self.bounds.size.height)
        self.backgroundView = type.view
    }

    func restore() {
        self.backgroundView = nil
    }
}
