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
    let searchButton = UIButton()
    let segControl = UISegmentedControl(items: ["GIFs", "Stickers", "Text"])
    
    let searchGifLayout = GifCollectionViewLayout()
    lazy var searchGifCollectionView = UICollectionView(frame: .zero,
                                                        collectionViewLayout: searchGifLayout)
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        attribute()
        layout()
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        guard textField.text != nil else { return }
    }
}

extension SearchResultView: SearchResultViewProtocol {
    func didReceiveSearchGif() {
        searchGifCollectionView.reloadData()
    }
    
    func showLoading() {
        //        <#code#>
    }
    
    func hideLoading() {
        //        <#code#>
    }
    
    func showError() {
        print("에러에요")
    }
}


extension SearchResultView {
    func attribute() {
        navigationItem.do {
            let title = UILabel()
            title.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 20)
            title.text = "Search"
            $0.titleView = title
        }
        searchTextField.do {
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
            $0.setImage(UIImage().setSFSymbols(systemName: "magnifyingglass",
                                               weight: .bold), for: .normal)
            $0.tintColor = .white
            $0.backgroundColor = .purple
        }
        segControl.do {
            $0.backgroundColor = .orange
        }
        searchGifCollectionView.do {
            $0.backgroundColor = .cyan
            $0.register(SearchGifCollectionViewCell.self,
                        forCellWithReuseIdentifier: SearchGifCollectionViewCell.id)
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    func layout() {
        [searchTextField,
         searchButton,
         segControl,
         searchGifCollectionView].forEach {
            view.addSubview($0)
            autoResizingOff($0)
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
        segControl.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: searchTextField.bottomAnchor,
                                        constant: 3),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        searchGifCollectionView.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: segControl.bottomAnchor,
                                        constant: 3),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
    
    func autoResizingOff(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension SearchResultView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfSearchGif() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter = presenter else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                        SearchGifCollectionViewCell.id,
                                                      for: indexPath)
        guard let castedCell = cell as? SearchGifCollectionViewCell else { return UICollectionViewCell() }
        castedCell.setData(presenter.itemOfSearchGif(indexPath))
        return castedCell
    }
}

extension SearchResultView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text != nil else { return false }
        //        presenter?.searchKeyword(keyword)
        return true
    }
}

extension SearchResultView: GifCollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        guard let image = presenter?.getGifImage(indexPath) else { return 0 }
        return UIImage(data: image)?.size.height ?? 0
    }
}
