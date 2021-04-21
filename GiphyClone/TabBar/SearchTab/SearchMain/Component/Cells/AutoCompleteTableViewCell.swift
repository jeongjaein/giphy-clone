//
//  AutoCompleteTableViewCell.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class AutoCompleteTableViewCell: UITableViewCell {
    static let id = "AutoCompleteTableViewCell"
    
    let keywordLabel = SubHeadingLabel()
    let iconImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    func setData(keyword: String) {
        keywordLabel.text = keyword
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: attribute & layout

extension AutoCompleteTableViewCell {
    func attribute() {
        self.do {
            $0.selectionStyle = .none
        }
        keywordLabel.do {
            $0.font.withSize(18)
        }
        iconImageView.do {
            $0.tintColor = .gray
            $0.image = UIImage().setSFSymbols(systemName: "magnifyingglass",
                                              weight: .bold)
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
    }
    
    func layout() {
        [keywordLabel, iconImageView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        iconImageView.do {
            NSLayoutConstraint.activate([
                $0.centerYAnchor.constraint(equalTo: centerYAnchor),
                $0.leadingAnchor.constraint(
                    equalTo: leadingAnchor, constant: 10),
                $0.widthAnchor.constraint(equalToConstant: 15)
            ])
        }
        keywordLabel.do {
            NSLayoutConstraint.activate([
                $0.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
                $0.leadingAnchor.constraint(
                    equalTo: iconImageView.trailingAnchor, constant: 10)
            ])
        }
    }
    
}
