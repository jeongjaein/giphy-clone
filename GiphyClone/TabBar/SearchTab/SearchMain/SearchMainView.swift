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
    let segControl = UISegmentedControl(items: ["GIFs", "Stickers", "Text"])
    let trendingSearchesLabel = SubHeadingLabel()
    let autoCompleteTableView = UITableView()
    
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
        autoCompleteTableView.reloadData()
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
    
    //MARK: @objc
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        guard let keyword = textField.text else { return }
        presenter?.searchTextFieldChanged(keyword)
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
        trendingSearchesLabel.do {
            $0.text = "Trending Searches"
        }
        autoCompleteTableView.do {
            $0.separatorStyle = .none
            $0.isScrollEnabled = false
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = .black
            $0.estimatedRowHeight = 15
            $0.rowHeight = UITableView.automaticDimension
            $0.register(AutoCompleteTableViewCell.self,
                        forCellReuseIdentifier: AutoCompleteTableViewCell.id)
        }
    }
    
    func layout() {
        [searchTextField,
         searchButton,
         segControl,
         trendingSearchesLabel,
         autoCompleteTableView].forEach {
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
        trendingSearchesLabel.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: segControl.bottomAnchor,
                                        constant: 10),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                            constant: 10),
            ])
        }
        autoCompleteTableView.do {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: trendingSearchesLabel.bottomAnchor,
                                        constant: 3),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.heightAnchor.constraint(equalToConstant: 230)
            ])
        }
    }
    
    func autoResizingOff(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension SearchMainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfAutoComplete() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: AutoCompleteTableViewCell.id, for: indexPath)
        guard let castedCell = cell as? AutoCompleteTableViewCell else { return UITableViewCell() }
        castedCell.setData(keyword: presenter.itemOfAutoComplete(indexPath))
        return castedCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectAutoComplete(indexPath)
    }
}

extension SearchMainView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let keyword = textField.text else { return false }
        presenter?.searchKeyword(keyword)
        return true
    }
}
