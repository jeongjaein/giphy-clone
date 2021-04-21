//
//  GifDetailView.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class GifDetailView: UIViewController {
    var presenter: GifDetailPresenterProtocol?
    
    let gifDetailCollectionView = UITableView()
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
        attribute()
        layout()
        setView()
    }
}

extension GifDetailView: GifDetailViewProtocol {
    func setView() {
        guard (presenter?.getGifInfo()) != nil else { return }
        gifDetailCollectionView.reloadData()
    }
    func setLikeButton(_ state: Bool) {
        //        likeButton.tintColor = state ? .systemPink : .systemGray3
    }
}

extension GifDetailView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
                withIdentifier: GifDetailTableViewCell.id, for: indexPath)
            guard let castedCell = cell as? GifDetailTableViewCell else { return UITableViewCell() }
            castedCell.imageCollectionView.delegate = self
            castedCell.imageCollectionView.dataSource = self
//            castedCell.setData(presenter.getGifInfo().mainImage)
            return castedCell
        }
        if indexPath.section == 1
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

extension GifDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}

// MARK: attribute & layout

extension GifDetailView {
    func attribute() {
        gifDetailCollectionView.do {
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
