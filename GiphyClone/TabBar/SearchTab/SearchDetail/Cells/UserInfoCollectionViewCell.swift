//
//  UserInfoCollectionViewCell.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class UserInfoCollectionViewCell: UICollectionViewCell {
    static let id = "UserInfoCollectionViewCell"
    
    let userProfileImageView = UIImageView()
    let displayNameLabel = UILabel()
    let nameLabel = UILabel()
    let verifiedImageView = UIImageView()
    let likeButton = UIButton()
    let sendButton = UIButton()
    let moreButton = UIButton()
    
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

extension UserInfoCollectionViewCell {
    func attribute() {
        userProfileImageView.do { _ in
            
        }
        displayNameLabel.do {
            $0.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 20)
        }
        nameLabel.do {
            $0.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 14)
        }
        verifiedImageView.do {
            $0.image = UIImage()
                .setSFSymbols(
                    systemName: "checkmark.seal.fill",weight: .regular)
            $0.tintColor = .cyan
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        likeButton.do {
            $0.setImage(
                UIImage().setSFSymbols(
                    systemName: "heart.fill", weight: .bold),
                for: .normal)
            $0.tintColor = .systemGray3
        }
        moreButton.do {
            $0.setImage(
                UIImage().setSFSymbols(
                    systemName: "ellipsis", weight: .bold),
                for: .normal)
            $0.tintColor = .systemGray3
        }
    }
    
    func layout() {
        [
         userProfileImageView,
         displayNameLabel,
         nameLabel,
         verifiedImageView,
         likeButton,
         moreButton
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
         }
        
        userProfileImageView.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(
                    equalTo: topAnchor, constant: 10),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.widthAnchor.constraint(equalToConstant: 40)
            ])
        }
        displayNameLabel.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: userProfileImageView.topAnchor),
                $0.leadingAnchor.constraint(
                    equalTo: userProfileImageView.trailingAnchor, constant: 5),
                $0.bottomAnchor.constraint(equalTo: userProfileImageView.centerYAnchor)
            ])
        }
        nameLabel.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: userProfileImageView.centerYAnchor),
                $0.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
        sendButton.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: userProfileImageView.topAnchor),
                $0.trailingAnchor.constraint(
                    equalTo: moreButton.leadingAnchor, constant: -5),
                $0.bottomAnchor.constraint(equalTo: userProfileImageView.bottomAnchor)
            ])
        }
        moreButton.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: userProfileImageView.topAnchor),
                $0.trailingAnchor.constraint(
                    equalTo: trailingAnchor, constant: -10),
                $0.bottomAnchor.constraint(equalTo: userProfileImageView.bottomAnchor)
            ])
        }
        likeButton.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: userProfileImageView.topAnchor),
                $0.trailingAnchor.constraint(
                    equalTo: sendButton.leadingAnchor, constant: -5),
                $0.bottomAnchor.constraint(equalTo: userProfileImageView.bottomAnchor)
            ])
        }
    }
}
