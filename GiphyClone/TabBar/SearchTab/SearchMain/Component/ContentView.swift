//
//  ContentView.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class ContentView: UIView {
    
    let subHeadingLabel = SubHeadingLabel()
    var contentView = UIView()
    
    init(frame: CGRect = .zero, content: UIView = UIView()) {
        super.init(frame: frame)
        self.contentView = content
        layout()
    }
    
    func layout() {
        [subHeadingLabel, contentView].forEach { addSubview($0) }
        
        subHeadingLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            ])
        }
        contentView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: subHeadingLabel.bottomAnchor,
                                        constant: 5),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
