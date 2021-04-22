//
//  SearchMainCustomTab.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/23.
//

import UIKit

class SearchMainCustomTab: UIView {
    let leftButton      = UIButton()
    let centerButton    = UIButton()
    let rightButton     = UIButton()
    let moveMentView    = UIView()
    var old             = UIButton()
    
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

extension SearchMainCustomTab {
    func attribute() {
        self.do {
            $0.backgroundColor = .black
        }
        leftButton.do {
            $0.backgroundColor = .clear
            $0.setTitle("GIFs", for: .normal)
            $0.titleLabel?.textColor = .lightGray
            $0.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 20)
            $0.addTarget(
                self, action: #selector(buttonDidTap), for: .touchUpInside)
        }
        centerButton.do {
            $0.backgroundColor = .clear
            $0.setTitle("Stickers", for: .normal)
            $0.titleLabel?.textColor = .lightGray
            $0.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 20)
            $0.addTarget(
                self, action: #selector(buttonDidTap), for: .touchUpInside)
        }
        rightButton.do {
            $0.backgroundColor = .clear
            $0.setTitle("Text", for: .normal)
            $0.titleLabel?.textColor = .lightGray
            $0.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 20)
            $0.addTarget(
                self, action: #selector(buttonDidTap), for: .touchUpInside)
        }
        moveMentView.do {
            $0.backgroundColor = .cyan
        }
    }
    
    func layout() {
        [leftButton,
         centerButton,
         rightButton,
         moveMentView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
         }
        leftButton.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor),
                $0.trailingAnchor.constraint(equalTo: centerButton.leadingAnchor)
            ])
        }
//        moveMentView.do {
//            NSLayoutConstraint.activate([
//                $0.topAnchor.constraint(equalTo: topAnchor),
//                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
//                $0.bottomAnchor.constraint(equalTo: bottomAnchor),
//                $0.widthAnchor.constraint(equalToConstant: 100)
//            ])
//        }
        centerButton.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.centerXAnchor.constraint(equalTo: centerXAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor),
                $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3)
            ])
        }
        rightButton.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor),
                $0.leadingAnchor.constraint(equalTo: centerButton.trailingAnchor)
            ])
        }
    }
}

extension SearchMainCustomTab {
    func move(_ old: UIButton, _ new: UIButton) {
        let newSize = mutate(old, new)
        let xDiff = old.center.x - new.center.x
        let yDiff = old.center.y - new.center.y
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.moveMentView.frame = CGRect(
                x: old.frame.minX + xDiff,
                y: old.frame.minY + yDiff,
                width: newSize.width,
                height: newSize.height)
        }
    }
    
    func mutate(_ old: UIButton, _ new: UIButton) -> CGSize {
        guard let width = new.titleLabel?.frame.width,
              let height = new.titleLabel?.frame.height
        else { return CGSize.zero }
        
        return CGSize(width: width, height: height)
    }
    
    @objc func buttonDidTap(_ new: UIButton) {
        move(old, new)
        old = new
    }
}
