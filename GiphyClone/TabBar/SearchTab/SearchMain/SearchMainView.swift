//
//  SearchMainView.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/20.
//

import UIKit

class SearchMainView: UIViewController {
    var presenter: SearchMainPresenterProtocol?
    let searchTextField = UITextField()
    let searchButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        attribute()
        layout()
    }
}

extension SearchMainView: SearchMainViewProtocol {
    func didReceiveTrendingGif() {
        print("최신gif 도착~")
    }
    
    func didReceiveRecentSearches() {
        print("검색기록 도착~")
    }
    
    func didReceiveAutoCompletes() {
        print("자동완성 도착~")
    }
    
    func showLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func showError() {
        //alert pop 구현합시다
    }
}

// MARK: attribute & layout

extension SearchMainView {
    func attribute() {
        navigationItem.do {
            let title = UILabel()
            title.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 20)
            title.text = "Search"
            $0.titleView = title
        }
        searchTextField.do {
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
    }
    
    func layout() {
        [searchTextField, searchButton].forEach {
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
    }
    
    func autoResizingOff(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
