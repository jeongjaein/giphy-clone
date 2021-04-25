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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
    }
}

extension SearchMainCustomTab {
    func move(_ old: UIButton, _ new: UIButton) {
        [leftButton, centerButton, rightButton].forEach {
            $0.isUserInteractionEnabled = false
        }
        let diff = old.center.x - new.center.x
        guard var labelWidth = new.titleLabel?.frame.size.width else { return }
        labelWidth += 40
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.changeColor(new)
            self?.moveMentView.frame =
            (self?.calculate(new.frame, diff, labelWidth, -(abs(diff) / 4.5)))!
            
        } completion: { [weak self] _ in
            UIView.animate(withDuration: 0.15) { 
                self?.moveMentView.frame =
                    (self?.calculate(new.frame, diff, labelWidth, abs(diff) / 10))!
                
            } completion: { [weak self] _ in
                UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut]) {
                    self?.moveMentView.frame =
                        CGRect(x: new.frame.minX
                                + (old.frame.width - labelWidth) / 2,
                               y: new.frame.minY,
                               width: labelWidth,
                               height: new.frame.height)
                    [self?.leftButton, self?.centerButton, self?.rightButton].forEach {
                        $0?.isUserInteractionEnabled = true
                }
            }
        }
        
        }
    }
    
    func calculate(_ rect: CGRect,
                  _ diff: CGFloat,
                  _ labelWith: CGFloat,
                  _ correction: CGFloat) -> CGRect {
        
        let ratio = (old.frame.width - labelWith) / 2
        
        return CGRect(x: rect.minX
                        + ratio
                        + (diff < 0
                            ? -correction
                            : +correction),
                      y: rect.minY,
                      width: labelWith,
                      height: rect.height)
    }
    
    func changeColor(_ new: UIButton) {
        if new.tag == 1 {
            moveMentView.backgroundColor = AppColor.leftButton.value
        } else if new.tag == 2 {
            moveMentView.backgroundColor = AppColor.centerButton.value
        } else {
            moveMentView.backgroundColor = AppColor.rightButton.value
        }
    }
    
    @objc func buttonDidTap(_ new: UIButton) {
        move(old, new)
        old = new
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
            $0.backgroundColor = AppColor.leftButton.value
            $0.layer.cornerRadius = 20
            $0.clipsToBounds = true
            $0.alpha = 0.5
            $0.center.equalTo(leftButton.center)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.001) { [weak self] in
                guard let labelWidth = self?.leftButton.titleLabel?.frame.width,
                      let frameWidth = self?.leftButton.frame.width else { return }
                let correction = labelWidth + 40
                self?.moveMentView.frame = CGRect(x: (frameWidth - correction) / 2,
                                            y: 0,
                                            width: correction,
                                            height: (self?.frame.height)!)
                self?.old = self!.leftButton
            }
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
