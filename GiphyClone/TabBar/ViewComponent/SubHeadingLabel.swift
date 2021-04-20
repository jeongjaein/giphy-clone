//
//  SubHeadingLabel.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class SubHeadingLabel: UILabel {
    
    init(_ frame: CGRect? = .zero) {
        super.init(frame: frame!)
        self.text = text
        self.font = UIFont(name: "Apple SD Gothic Neo Regular", size: 15)
        self.backgroundColor = .black
        self.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
