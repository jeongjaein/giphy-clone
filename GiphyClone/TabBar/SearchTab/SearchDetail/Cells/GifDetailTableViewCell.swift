//
//  GifDetailTableViewCell.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class GifDetailTableViewCell: UITableViewCell {
    static let id = "GifDetailTableViewCell"

    let imageCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: String) {
//        mainImageView.setImageUrl(data)
    }
}

// MARK: attribute & layout

extension GifDetailTableViewCell {
    func attribute() {
        self.do {
            $0.selectionStyle = .none
        }
        imageCollectionView.do {
            $0.register(
                GifCardCollectionViewCell.self,
                forCellWithReuseIdentifier: GifCardCollectionViewCell.id)
        }
    }
    
    func layout() {
        [
         imageCollectionView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        imageCollectionView.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }
}
