//
//  SearchResultView.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class SearchResultView: UIViewController {
    var presenter: SearchResultPresenterProtocol?
    
    let searchTextField = UITextField()
    let searchButton    = UIButton()
//    let segControl      = UISegmentedControl(items: ["GIFs", "Stickers", "Text"])
    let searchGifLayout = GifCollectionViewLayout()
    let tabView         = SearchMainCustomTab()
    lazy var searchGifCollectionView = UICollectionView(frame: .zero, collectionViewLayout: searchGifLayout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        attribute()
        layout()
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        guard textField.text != nil else { return }
    }
    
    @objc func searchButtonDidTap() {
        guard let keyword = searchTextField.text else { return }
        presenter?.searchButtonDidTap(keyword)
    }
}

extension SearchResultView: SearchResultViewProtocol {
    func didReceiveSearchGif() {
        searchTextField.endEditing(true)
        searchGifCollectionView.scrollToItem(at: [0,0], at: .top, animated: false)
        searchGifCollectionView.reloadData()
    }
    
    func showLoading() {
        //        <#code#>
    }
    
    func hideLoading() {
        //        <#code#>
    }
    
    func showError() {
//        
    }
}


extension SearchResultView {
    func attribute() {
        searchGifCollectionView = UICollectionView(frame: .zero, collectionViewLayout: searchGifLayout)
        let fadeTextAnimation = CATransition()
        fadeTextAnimation.duration = 0.5
        fadeTextAnimation.startProgress = 1.0
        fadeTextAnimation.endProgress = 2.0
        fadeTextAnimation.type = .reveal
        navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "fadeText")
        navigationItem.do {
            let title = UILabel()
            title.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 20)
            title.text = presenter?.keyword
            $0.titleView = title
        }
        searchTextField.do {
            $0.text = presenter?.keyword
            $0.delegate = self
            $0.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
            $0.backgroundColor = .white
            $0.textColor = .black
            $0.font = UIFont(name: "Apple SD Gothic Neo Regular", size: 16)
            $0.addLeftPadding()
            $0.attributedPlaceholder
                = NSAttributedString(string: "Search GIPHY",
                                     attributes: [NSAttributedString.Key.foregroundColor
                                                    : UIColor.systemGray4])
        }
        searchButton.do {
            $0.tintColor = .white
            $0.backgroundColor = .purple
            $0.setImage(UIImage().setSFSymbols(systemName: "magnifyingglass",
                                               weight: .bold), for: .normal)
            $0.addTarget(self, action: #selector(searchButtonDidTap), for: .touchUpInside)
        }
        searchGifLayout.do {
            $0.delegate = self
        }
        searchGifCollectionView.do {
            $0.register(SearchGifCollectionViewCell.self,
                        forCellWithReuseIdentifier: SearchGifCollectionViewCell.id)
            $0.delegate = self
            $0.dataSource = self
            $0.keyboardDismissMode  = .interactive
        }
    }
    
    func layout() {
        [searchTextField,
         searchButton,
         tabView,
         searchGifCollectionView].forEach {
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
                $0.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
        searchGifCollectionView.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(
                    equalTo: tabView.bottomAnchor, constant: 3),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
}

extension SearchResultView:
    UICollectionViewDelegate,
    UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return presenter?.numberOfSearchGif() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter = presenter else { return UICollectionViewCell() }
        let cell = collectionView
            .dequeueReusableCell(
                withReuseIdentifier:SearchGifCollectionViewCell.id,for: indexPath)
        guard let castedCell = cell as? SearchGifCollectionViewCell else { return UICollectionViewCell() }
        castedCell.setData(presenter.getGifImage(indexPath))
        return castedCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectSearchGif(indexPath)
    }
}

extension SearchResultView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let keyword = textField.text else { return false }
        presenter?.searchButtonDidTap(keyword)
        return true
    }
}

extension SearchResultView: GifCollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView) -> [CGSize] {
        guard let heightList = presenter?.getImageHeightList() else { return [CGSize.zero] }
        return heightList
    }
}
