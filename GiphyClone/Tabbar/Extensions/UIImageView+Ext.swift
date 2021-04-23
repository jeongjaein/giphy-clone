//
//  UIImageView+Ext.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

extension UIImageView {
    func setImageUrl(_ url: String) {
        let key = NSString(string: url)
        if let cached = ImageCacheManager.shared.object(forKey: key) {
            self.image = cached
        } else {
            guard let url = URL(string: url) else { return }
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                            ImageCacheManager.shared.setObject(image , forKey: key)
                        }
                    }
                }
            }
        }
    }
    
    func setSFSymbols(systemName: String, weight: UIImage.SymbolWeight) {
        if let symbolImage = UIImage(systemName: systemName)?
            .withConfiguration(UIImage.SymbolConfiguration(weight: weight)) {
            self.image = symbolImage
        }
    }
}
