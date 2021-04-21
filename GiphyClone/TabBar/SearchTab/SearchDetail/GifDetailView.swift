//
//  GifDetailView.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class GifDetailView: UIViewController {
    var presenter: GifDetailPresenterProtocol?
    
    let gifDetailCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
        attribute()
        layout()
    }
}

extension GifDetailView: GifDetailViewProtocol {
    func setView() {
        guard (presenter?.getGifInfo()) != nil else { return }
//        mainImageView.setImageUrl(info.mainImage)
    }
    func setLikeButton(_ state: Bool) {
//        likeButton.tintColor = state ? .systemPink : .systemGray3
    }
}

extension GifDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

// MARK: attribute & layout

extension GifDetailView {
    func attribute() {
        gifDetailCollectionView.do {
            $0.backgroundColor = .red
            $0.delegate = self
        }
    }
    
    func layout() {
        [gifDetailCollectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        gifDetailCollectionView.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
}
