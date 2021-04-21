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
    
    func setData(_ data: String) {
        imageView.setImageUrl(data)
        imageView.sizeToFit()
        let ratio = imageView.image!.size.width / imageView.image!.size.height
        if imageView.frame.width > imageView.frame.height {
            let newHeight = imageView.frame.width / ratio
            imageView.frame.size = CGSize(width: imageView.frame.width, height: newHeight)
        }
        else{
            let newWidth = imageView.frame.height * ratio
            imageView.frame.size = CGSize(width: newWidth, height: imageView.frame.height)
        }
    }
}

// MARK: attribute & layout

extension SearchGifCollectionViewCell {
    func attribute() {
        imageView.do {
            $0.layer.cornerRadius = 2
            $0.layer.masksToBounds = true
            $0.contentMode = .scaleAspectFill
            imageView.image = UIImage().setSFSymbols(systemName: "line.diagonal.arrow", weight: .bold)
        }
    }
    
    func layout() {
        [imageView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
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
