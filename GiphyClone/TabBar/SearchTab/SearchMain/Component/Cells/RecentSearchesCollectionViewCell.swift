//
//  RecentSearchesCollectionViewCell.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/22.
//

import UIKit

class RecentSearchesCollectionViewCell: UICollectionViewCell {
    static let id = "RecentSearchesCollectionViewCell"

    let clockImageView = UIImageView()
    let keywordLabel = UILabel()
    
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

extension RecentSearchesCollectionViewCell {
    func attribute() {
        contentView.do {
            $0.backgroundColor = .systemGray4
            $0.layer.cornerRadius = 20
            $0.clipsToBounds = true
        }
        clockImageView.do {
            $0.tintColor = .yellow
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
            $0.setSFSymbols(systemName: "clock.arrow.circlepath", weight: .regular)
        }
        keywordLabel.do {
            $0.text = "tst"
            $0.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 20)
            $0.textColor = .white
        }
    }
    
    func layout() {
        [clockImageView, keywordLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        clockImageView.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: contentView.topAnchor),
                $0.leadingAnchor.constraint(
                    equalTo: contentView.leadingAnchor, constant: 8),
                $0.heightAnchor.constraint(equalToConstant: 15),
                $0.bottomAnchor.constraint(
                    equalTo: contentView.bottomAnchor)
            ])
        }
        keywordLabel.do {
            NSLayoutConstraint.activate([
                $0.centerYAnchor.constraint(equalTo: clockImageView.centerYAnchor),
                $0.leadingAnchor.constraint(
                    equalTo: clockImageView.trailingAnchor, constant: 2),
                $0.trailingAnchor.constraint(
                    equalTo: contentView.trailingAnchor, constant: -8)
            ])
        }
    }
}
