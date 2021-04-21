//
//  UserInfoCollectionViewCell.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {
    static let id = "UserInfoTableViewCell"
    
    let userProfileImageView = UIImageView()
    let displayNameLabel = UILabel()
    let nameLabel = UILabel()
    let verifiedImageView = UIImageView()
    let likeButton = UIButton()
    let sendButton = UIButton()
    let moreButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: GifDetail) {
        if !data.profileImage.isEmpty {
            userProfileImageView.setImageUrl(data.profileImage)
        }
        if !data.displayName.isEmpty {
            displayNameLabel.text = data.displayName
        }
        if !data.username.isEmpty {
            nameLabel.text = "@" + data.username
        }
        verifiedImageView.tintColor = data.isVerified ? .cyan : .gray
    }
}

// MARK: attribute & layout

extension UserInfoTableViewCell {
    func attribute() {
        self.do {
            $0.selectionStyle = .none
        }
        userProfileImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.tintColor = .systemGray3
            $0.image = UIImage().setSFSymbols(
                systemName: "square.dashed", weight: .bold)
        }
        displayNameLabel.do {
            $0.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 16)
        }
        nameLabel.do {
            $0.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 15)
        }
        verifiedImageView.do {
            $0.image = UIImage()
                .setSFSymbols(
                    systemName: "checkmark.seal.fill",weight: .regular)
            $0.tintColor = .cyan
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
        likeButton.do {
            $0.setImage(
                UIImage().setSFSymbols(
                    systemName: "heart.fill", weight: .bold),
                for: .normal)
            $0.tintColor = .white
        }
        sendButton.do {
            $0.setImage(
                UIImage().setSFSymbols(
                    systemName: "paperplane.fill", weight: .bold),
                for: .normal)
            $0.tintColor = .white
        }
        moreButton.do {
            $0.setImage(
                UIImage().setSFSymbols(
                    systemName: "ellipsis", weight: .bold),
                for: .normal)
            $0.tintColor = .white
        }
    }
    
    func layout() {
        [
            userProfileImageView,
            displayNameLabel,
            nameLabel,
            verifiedImageView,
            likeButton,
            sendButton,
            moreButton
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        userProfileImageView.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(
                    equalTo: topAnchor, constant: 10),
                $0.leadingAnchor.constraint(
                    equalTo: leadingAnchor, constant: 10),
                $0.widthAnchor.constraint(equalToConstant: 40),
                $0.heightAnchor.constraint(equalToConstant: 40),
                $0.bottomAnchor.constraint(
                    equalTo: bottomAnchor, constant: -10)
            ])
        }
        displayNameLabel.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: userProfileImageView.topAnchor),
                $0.leadingAnchor.constraint(
                    equalTo: userProfileImageView.trailingAnchor, constant: 15),
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
        verifiedImageView.do {
            NSLayoutConstraint.activate([
                $0.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
                $0.widthAnchor.constraint(equalToConstant: 20),
                $0.leadingAnchor.constraint(
                    equalTo: nameLabel.trailingAnchor, constant: 10),
            ])
        }
        moreButton.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: userProfileImageView.topAnchor),
                $0.trailingAnchor.constraint(
                    equalTo: trailingAnchor, constant: -20),
                $0.bottomAnchor.constraint(equalTo: userProfileImageView.bottomAnchor)
            ])
        }
        sendButton.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: userProfileImageView.topAnchor),
                $0.trailingAnchor.constraint(
                    equalTo: moreButton.leadingAnchor, constant: -20),
                $0.bottomAnchor.constraint(equalTo: userProfileImageView.bottomAnchor)
            ])
        }
        likeButton.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: userProfileImageView.topAnchor),
                $0.trailingAnchor.constraint(
                    equalTo: sendButton.leadingAnchor, constant: -20),
                $0.bottomAnchor.constraint(equalTo: userProfileImageView.bottomAnchor)
            ])
        }
    }
}