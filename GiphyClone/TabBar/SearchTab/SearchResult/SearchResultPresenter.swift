//
//  SearchResultPresenter.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import Foundation

class SearchResultPresenter: SearchResultPresenterProtocol {
    var view: SearchResultViewProtocol?
    var interactor: SearchResultInteractorInputProtocol?
    var wireFrame: SearchResultWireFrameProtocol?
    
    var keyword: String = ""
    var searchGif: SearchGif?
    
    func viewDidLoad() {
        interactor?.fetchSearchGif(keyword)
    }
    
    func searchButtonDidTap(_ keyword: String) {
        interactor?.fetchSearchGif(keyword)
    }
}

extension SearchResultPresenter: SearchResultInteractorOutputProtocol {
    func retrievedSearchKeyword(_ searchGif: SearchGif) {
        self.searchGif = searchGif
        view?.hideLoading()
        view?.didReceiveSearchGif()
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
}
