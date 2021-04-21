//
//  GifDetailTableViewCell.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class GifDetailTableViewCell: UITableViewCell {
    static let id = "GifDetailTableViewCell"
    
    let mainImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: String) {
        mainImageView.setImageUrl(data)
    }
}

// MARK: attribute & layout

extension GifDetailTableViewCell {
    func attribute() {
        self.do {
            $0.selectionStyle = .none
        }
        mainImageView.do {
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.contentMode = .scaleAspectFill
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
                    equalTo: leadingAnchor, constant: 20),
                $0.trailingAnchor.constraint(
                    equalTo: trailingAnchor, constant: -20),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }
}
