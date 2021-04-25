//
//  AutoCompleteTableViewCell.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class SearchMainTopTableViewCell: UITableViewCell {
    static let id = "SearchMainTopTableViewCell"
    
    let keywordLabel = SubHeadingLabel()
    let iconImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    
    func setData(state: Bool, keyword: String) {
        iconImageView.setSFSymbols(systemName: state
                                    ? "magnifyingglass"
                                    : "line.diagonal.arrow",
                                   weight: .bold)
        iconImageView.tintColor = state ? .gray : AppColor.arrow.value
        keywordLabel.text = keyword
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: attribute & layout

extension SearchMainTopTableViewCell {
    func attribute() {
        self.do {
            $0.selectionStyle = .none
        }
        keywordLabel.do {
            $0.font.withSize(18)
        }
        iconImageView.do {
            $0.tintColor = .gray
            $0.image = UIImage().setSFSymbols(
                systemName: "magnifyingglass", weight: .bold)
            $0.contentMode = .scaleAspectFit
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
                    equalTo: leadingAnchor, constant: 15),
                $0.widthAnchor.constraint(equalToConstant: 20)
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
