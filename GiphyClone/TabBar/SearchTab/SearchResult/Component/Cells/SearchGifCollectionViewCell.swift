//
//  SearchGifCollectionViewCell.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class SearchGifCollectionViewCell: UICollectionViewCell {
    static let id = "SearchGifCollectionViewCell"
    
    let imageView = UIImageView()
    
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
    
    func setData(_ data: Data) {
        imageView.image = UIImage(data: data)
    }
}

// MARK: attribute & layout

extension SearchGifCollectionViewCell {
    func attribute() {
        imageView.do {
            $0.layer.cornerRadius = 3
            $0.layer.masksToBounds = true
            $0.contentMode = .scaleAspectFill
        }
    }
    
    func layout() {
        [imageView].forEach { addSubview($0) }
        
        imageView.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }
}
