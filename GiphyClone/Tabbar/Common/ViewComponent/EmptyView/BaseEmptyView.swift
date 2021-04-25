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
            $0.backgroundColor  = .black
        }
        iconImageView.do {
            $0.clipsToBounds    = true
            $0.tintColor        = .lightGray
            $0.contentMode      = .scaleAspectFill
        }
        guideLabel.do {
            $0.textAlignment    = .center
            $0.textColor        = .lightGray
            $0.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 25)
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
                $0.centerXAnchor.constraint(equalTo: centerXAnchor),
                $0.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.33),
                $0.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.33)
            ])
        }
        guideLabel.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(
                    equalTo: iconImageView.bottomAnchor, constant: 50),
                $0.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
