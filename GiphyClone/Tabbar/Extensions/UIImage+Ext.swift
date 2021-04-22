//
//  UIImage+Ext.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

extension UIImage {
    // MARK: SfSymbols -> UIImage
    func setSFSymbols(systemName: String, weight: SymbolWeight) -> UIImage {
        if let symbolImage = UIImage(systemName: systemName)?
            .withConfiguration(UIImage.SymbolConfiguration(weight: weight)) {
            return symbolImage
        } else {
            return UIImage()
        }
    }
}


