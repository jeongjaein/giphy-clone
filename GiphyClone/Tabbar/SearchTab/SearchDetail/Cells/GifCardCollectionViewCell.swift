//
//  GifCardCollectionViewCell.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/22.
//

import UIKit

class GifCardCollectionViewCell: UICollectionViewCell {
    static let id = "GifCardCollectionViewCell"
    
    let mainImageView = UIImageView()
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: attribute & layout

extension GifCardCollectionViewCell {
    func attribute() {
        mainImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
    }
    
    func layout() {
        [mainImageView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        mainImageView.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }
}
