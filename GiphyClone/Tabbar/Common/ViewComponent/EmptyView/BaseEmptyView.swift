//
//  BaseEmptyView.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/26.
//

import UIKit

class BaseEmptyView: UIView {
    let iconImageView = UIImageView()
    let guideLabel = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.backgroundColor = .black
        }
        iconImageView.do {
            $0.tintColor = .systemGray3
            $0.contentMode = .scaleAspectFill
        }
        guideLabel.do {
            $0.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 20)
            $0.textColor = .systemGray3
        }
    }
    
    func layout() {
        [iconImageView, guideLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        iconImageView.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(
                    equalTo: topAnchor, constant: 100),
                $0.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                $0.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.33)
            ])
        }
        guideLabel.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(
                    equalTo: iconImageView.bottomAnchor, constant: 50),
                $0.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
