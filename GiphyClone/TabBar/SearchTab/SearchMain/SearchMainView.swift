//
//  SearchMainView.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/20.
//

import UIKit

class SearchMainView: UIViewController {
    var presenter: SearchMainPresenterProtocol?
    
    let searchTextField       = UITextField()
    let searchButton          = UIButton()
//    let segueControl          = UISegmentedControl(items: ["GIFs", "Stickers", "Text"])
    let tabView               = SearchMainCustomTab()
    let trendingSearchesLabel = SubHeadingLabel()
    let autoCompleteTableView = UITableView()
    
    let recentSearchesCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: SearchMainView.recentSearchesLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        attribute()
        layout()
    }
    
    //MARK: @objc
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        guard let keyword = textField.text else { return }
        presenter?.searchTextFieldChanged(keyword)
    }
    
    @objc func searchButtonDidTap() {
        guard let keyword = searchTextField.text else { return }
        presenter?.searchKeyword(keyword)
    }
    
    @objc func segueDidTap(seg: UISegmentedControl) {
        
    }
}

extension SearchMainView: SearchMainViewProtocol {
    func topTableviewReload(_ subTitle: String? = nil) {
        autoCompleteTableView.reloadData()
        guard let title = subTitle else { return }
        trendingSearchesLabel.text = title
    }
    
    func didReceiveTrendingGif() {
        print("최신gif 도착~")
    }
    
    func didReceiveRecentSearches() {
        recentSearchesCollectionView.reloadData()
    }
    
    func showLoading() {
        //
    }
    
    func hideLoading() {
        //
    }
    
    func showError() {
        //alert pop 구현합시다
    }
}

// MARK: TableView

extension SearchMainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfList() ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchMainTopTableViewCell.id, for: indexPath)
        guard let castedCell = cell as? SearchMainTopTableViewCell else { return UITableViewCell() }
        let data = presenter.itemOfList(indexPath)
        castedCell.setData(state: data.0, keyword: data.1)
        return castedCell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectOfList(indexPath)
    }
}

// MARK: CollectionView

extension SearchMainView: UICollectionViewDelegate,
                          UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRecentSearches() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter = presenter else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecentSearchesCollectionViewCell.id, for: indexPath)
        guard let castedCell = cell as? RecentSearchesCollectionViewCell else { return UICollectionViewCell() }
        castedCell.setData(presenter.itemOfRecentSearches(indexPath))
        return castedCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectRecentSearches(indexPath)
    }
}

// MARK: TextField

extension SearchMainView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let keyword = textField.text else { return false }
        presenter?.searchKeyword(keyword)
        return true
    }
    
}

// MARK: Static Func

extension SearchMainView {
    
    static func recentSearchesLayout() -> UICollectionViewCompositionalLayout {
        
        let size = NSCollectionLayoutSize(
            widthDimension: .estimated(100),
            heightDimension: .estimated(50))
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: size, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: attribute & layout

extension SearchMainView {
    func attribute() {
        navigationItem.do {
            let title           = UILabel()
            title.text          = "Search"
            $0.titleView        = title
            $0.backButtonTitle  = ""
            title.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 20)
        }
        searchTextField.do {
            $0.addLeftPadding()
            $0.delegate         = self
            $0.tintColor        = .black
            $0.textColor        = .black
            $0.backgroundColor  = .white
            $0.clearButtonMode  = .whileEditing
            $0.font = UIFont(name: "Apple SD Gothic Neo Regular", size: 16)
            $0.addTarget(
                self, action: #selector(textFieldDidChanged), for: .editingChanged)
            $0.attributedPlaceholder
                = NSAttributedString(
                    string: "Search GIPHY",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        }
        searchButton.do {
            $0.tintColor        = .white
            $0.backgroundColor  = .purple
            $0.setImage(
                UIImage().setSFSymbols(
                    systemName: "magnifyingglass", weight: .bold), for: .normal)
            $0.addTarget(
                self, action: #selector(searchButtonDidTap), for: .touchUpInside)
        }
//        segueControl.do {
//            $0.clearBG()
//            $0.selectedSegmentIndex     = 0
//            $0.backgroundColor          = .clear
//            $0.selectedSegmentTintColor = .clear
//            $0.addTarget(self, action: #selector(segueDidTap), for: .valueChanged)
//            $0.setTitleTextAttributes(
//                [.font: UIFont(name: "Apple SD Gothic Neo Bold", size: 20) as Any,
//                 .foregroundColor: UIColor.lightGray], for: .normal)
//            $0.setTitleTextAttributes(
//                [.font: UIFont(name: "Apple SD Gothic Neo Bold", size: 20) as Any,
//                 .foregroundColor: UIColor.white], for: .selected)
//
//        }
        tabView.do { _ in
            
        }
        trendingSearchesLabel.do {
            $0.text = "Trending Searches"
        }
        autoCompleteTableView.do {
            $0.delegate             = self
            $0.dataSource           = self
            $0.separatorStyle       = .none
            $0.isScrollEnabled      = false
            $0.estimatedRowHeight   = 15
            $0.backgroundColor      = .black
            $0.keyboardDismissMode  = .interactive
            $0.rowHeight = UITableView.automaticDimension
            $0.register(SearchMainTopTableViewCell.self,
                        forCellReuseIdentifier: SearchMainTopTableViewCell.id)
        }
        recentSearchesCollectionView.do {
            $0.delegate                 = self
            $0.dataSource               = self
            $0.isPagingEnabled          = false
            $0.alwaysBounceVertical     = false
            $0.alwaysBounceHorizontal   = false
            $0.register(RecentSearchesCollectionViewCell.self,
                        forCellWithReuseIdentifier: RecentSearchesCollectionViewCell.id)
        }
    }
    
    func layout() {
        [searchTextField,
         searchButton,
//         segueControl,
         tabView,
         trendingSearchesLabel,
         autoCompleteTableView,
         recentSearchesCollectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
         }
        
        searchTextField.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor),
                $0.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        searchButton.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: searchTextField.topAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.heightAnchor.constraint(equalTo: searchTextField.heightAnchor),
                $0.widthAnchor.constraint(equalTo: searchTextField.heightAnchor)
            ])
        }
        tabView.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(
                    equalTo: searchTextField.bottomAnchor, constant: 3),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.heightAnchor.constraint(equalToConstant: 35)
            ])
        }
        trendingSearchesLabel.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(
                    equalTo: tabView.bottomAnchor, constant: 10),
                $0.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor, constant: 10),
            ])
        }
        autoCompleteTableView.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(
                    equalTo: trendingSearchesLabel.bottomAnchor, constant: 3),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.heightAnchor.constraint(equalToConstant: 230)
            ])
        }
        recentSearchesCollectionView.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: autoCompleteTableView.bottomAnchor),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
    }
}
