//
//  GifDetailView.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class GifDetailView: UIViewController {
    var presenter: GifDetailPresenterProtocol?
    
    let gifDetailTableView = UITableView()
    let imageCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let testview: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    override func viewDidLoad() {
        presenter?.viewDidLoad()
        attribute()
        layout()
        setView()
    }
}

extension GifDetailView: GifDetailViewProtocol {
    func setView() {
        gifDetailTableView.reloadData()
        
    }
    func setLikeButton(_ state: Bool) {
        //        likeButton.tintColor = state ? .systemPink : .systemGray3
    }
}

extension GifDetailView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 100
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return imageCollectionView
        } else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 0
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else { return UITableViewCell() }
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: UserInfoTableViewCell.id, for: indexPath)
            guard let castedCell = cell as? UserInfoTableViewCell else { return UITableViewCell() }
            castedCell.setData(presenter.getGifInfo())
            return castedCell
        }
        return UITableViewCell()
    }
}

extension GifDetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfGifs() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter = presenter else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GifCardCollectionViewCell.id, for: indexPath)
        guard let castedCell = cell as? GifCardCollectionViewCell else { return UICollectionViewCell() }
        castedCell.mainImageView.setImageUrl(presenter.itemOfGifs(indexPath).mainImage)
        return castedCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

// MARK: attribute & layout

extension GifDetailView {
    func attribute() {
        gifDetailTableView.do {
            $0.backgroundColor = .red
            $0.delegate = self
            $0.dataSource = self
            $0.estimatedRowHeight = 400
            $0.rowHeight = UITableView.automaticDimension
            $0.register(
                GifDetailTableViewCell.self,
                forCellReuseIdentifier: GifDetailTableViewCell.id)
            $0.register(
                UserInfoTableViewCell.self,
                forCellReuseIdentifier: UserInfoTableViewCell.id)
        }
        imageCollectionView.do {
            $0.register(
                GifCardCollectionViewCell.self,
                forCellWithReuseIdentifier: GifCardCollectionViewCell.id)
            ($0.collectionViewLayout as? UICollectionViewFlowLayout)?
                .scrollDirection = .horizontal
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    func layout() {
        [gifDetailTableView,
         imageCollectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        gifDetailTableView.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
//        imageCollectionView.do {
//            NSLayoutConstraint.activate([
//                $0.topAnchor.constraint(equalTo: topAnchor),
//                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
//                $0.trailingAnchor.constraint(equalTo: trailingAnchor),
//                $0.heightAnchor.constraint(equalTo: $0.heightAnchor, multiplier: 0.5)
//            ])
//        }
    }
}
