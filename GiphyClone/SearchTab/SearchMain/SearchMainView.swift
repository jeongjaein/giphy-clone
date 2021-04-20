//
//  SearchMainView.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/20.
//

import UIKit

class SearchMainView: UIViewController {
    var presenter: SearchMainPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension SearchMainView: SearchMainViewProtocol {
    func didReceiveTrendingGif() {
        <#code#>
    }
    
    func didReceiveRecentSearches() {
        <#code#>
    }
    
    func didReceiveAutoCompletes() {
        <#code#>
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
