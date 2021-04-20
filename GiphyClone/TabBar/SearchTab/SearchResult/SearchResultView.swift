//
//  SearchResultView.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class SearchResultView: UIViewController {
    var presenter: SearchResultPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension SearchResultView: SearchResultViewProtocol {
    func didReceiveSearchGif() {
        print("도착이요")
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
