//
//  GifDetailCollectionViewcell.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class GifDetailCollectionViewcell: UICollectionViewCell {
    static let id = "GifDetailCollectionViewcell"
    
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
    
    func setData(_ data: String) {
//        imageView.setImageUrl(data)
    }
}

// MARK: attribute & layout

extension GifDetailCollectionViewcell {
    func attribute() {
        mainImageView.do {
            $0.layer.cornerRadius = 3
            $0.layer.masksToBounds = true
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
    }
    
    func layout() {
        [mainImageView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        mainImageView.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.leadingAnchor.constraint(
                    equalTo: leadingAnchor, constant: 5),
                $0.trailingAnchor.constraint(
                    equalTo: trailingAnchor, constant: -5),
                $0.heightAnchor.constraint(equalToConstant: 250)
            ])
        }
    }
}
