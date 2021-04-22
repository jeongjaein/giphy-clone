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
            $0.tag = 1
            $0.backgroundColor = .clear
            $0.setTitle("GIFs", for: .normal)
            $0.titleLabel?.textColor = .lightGray
            $0.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 20)
            $0.addTarget(
                self, action: #selector(buttonDidTap), for: .touchUpInside)
        }
        centerButton.do {
            $0.tag = 2
            $0.backgroundColor = .clear
            $0.setTitle("Stickers", for: .normal)
            $0.titleLabel?.textColor = .lightGray
            $0.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 20)
            $0.addTarget(
                self, action: #selector(buttonDidTap), for: .touchUpInside)
        }
        rightButton.do {
            $0.tag = 3
            $0.backgroundColor = .clear
            $0.setTitle("Text", for: .normal)
            $0.titleLabel?.textColor = .lightGray
            $0.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 20)
            $0.addTarget(
                self, action: #selector(buttonDidTap), for: .touchUpInside)
        }
        moveMentView.do {
            $0.backgroundColor = .cyan
            $0.layer.cornerRadius = 17
            $0.clipsToBounds = true
            $0.alpha = 0.5
        }
    }
    
    func layout() {
        [moveMentView,
         leftButton,
         centerButton,
         rightButton].forEach {
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
        let xDiff = old.center.x - new.center.x
        guard var labelSize = new.titleLabel?.frame.size.width else { return }
        labelSize += 60
        let cellSizing = (old.frame.width - labelSize) / 2
        UIView.animate(withDuration: 0.2) { [weak self] in
            let firstCorrection = abs(old.center.x - new.center.x) / 4.5
            self?.moveMentView.frame = CGRect(
                x: new.frame.minX
                    + cellSizing
                    + (xDiff < 0 ? +firstCorrection : -firstCorrection),
                y: new.frame.minY,
                width: labelSize,
                height: new.frame.height)
            
            if new.tag == 1 {
                self?.moveMentView.backgroundColor = .purple
            } else if new.tag == 2 {
                self?.moveMentView.backgroundColor = .green
            } else {
                self?.moveMentView.backgroundColor = .systemPink
            }
        } completion: { [weak self] _ in
            UIView.animate(withDuration: 0.15) {
                let secondCorrection = abs(old.center.x - new.center.x) / 10
                self?.moveMentView.frame = CGRect(
                    x: new.frame.minX
                        + cellSizing
                        + (xDiff < 0 ? -secondCorrection : +secondCorrection),
                    y: new.frame.minY,
                    width: labelSize,
                    height: new.frame.height
                )
            } completion: { [weak self] _ in
                UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut]) {
                    self?.moveMentView.frame =
                        CGRect(x: new.frame.minX + cellSizing,
                               y: new.frame.minY,
                               width: labelSize,
                               height: new.frame.height)
                }
            }
        }
    }
    
    func animate(_ rect: CGRect) -> CGRect {
        
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
