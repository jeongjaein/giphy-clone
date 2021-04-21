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
    var collectionViewLayout = UICollectionViewFlowLayout()
    var imageCollectionView
        = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var likeButton = UIButton()
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
        attribute()
        layout()
        setView()
    }
    
    // MARK:  @objc
    @objc func likeButtonDidTap() {
        //        presenter?.likeButtonDidTap(<#T##index: IndexPath##IndexPath#>)
        //        imageCollectionView.indexPath(for: imageCollectionView.visibleCells.last!)?.row
    }
}

extension GifDetailView: GifDetailViewProtocol {
    func setView() {
        gifDetailTableView.reloadData()
        imageCollectionView.scrollToItem(at: [0,10], at: .right, animated: false)
    }
    func setLikeButton(_ state: Bool) {
        guard let info = gifDetailTableView.cellForRow(at: [0,0])
                as? UserInfoTableViewCell else { return }
        info.likeButton.tintColor = state ? .systemPink : .systemGray3
    }
}

extension GifDetailView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ?imageCollectionView.frame.height : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? imageCollectionView : nil
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
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: UserInfoTableViewCell.id, for: indexPath)
            guard let castedCell = cell as? UserInfoTableViewCell else { return UITableViewCell() }
            likeButton = castedCell.likeButton
            likeButton.addTarget(self, action: #selector(likeButtonDidTap), for: .touchUpInside)
            castedCell.setData(presenter.getGifInfo())
            return castedCell
        }
        return UITableViewCell()
    }
}

extension GifDetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width,
                      height: collectionView.frame.height)
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
    
      internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let onlyOne = presenter?.getOnlyOne() else { return }
        if !onlyOne.0 {
            let indexToScrollTo = IndexPath(item: onlyOne.1, section: 0)
            self.imageCollectionView.scrollToItem(at: indexToScrollTo, at: .left, animated: false)
        }
        presenter?.toggleOnlyOne()
      }
}

// MARK: attribute & layout

extension GifDetailView {
    func attribute() {
        gifDetailTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.estimatedRowHeight = 400
            $0.rowHeight = UITableView.automaticDimension
            $0.bounces = false
            $0.register(
                UserInfoTableViewCell.self,
                forCellReuseIdentifier: UserInfoTableViewCell.id)
        }
        collectionViewLayout.do {
            $0.minimumLineSpacing = 0
            $0.scrollDirection = .horizontal
        }
        imageCollectionView.do {
            $0.collectionViewLayout = collectionViewLayout
            $0.register(
                GifCardCollectionViewCell.self,
                forCellWithReuseIdentifier: GifCardCollectionViewCell.id)
            ($0.collectionViewLayout as? UICollectionViewFlowLayout)?
                .scrollDirection = .horizontal
            $0.delegate = self
            $0.dataSource = self
            $0.decelerationRate = .fast
            $0.showsHorizontalScrollIndicator = false
            $0.isPagingEnabled = true
            $0.frame = CGRect(x: 0,
                              y: 0,
                              width: gifDetailTableView.frame.width,
                              height: 400)
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
    }
}
