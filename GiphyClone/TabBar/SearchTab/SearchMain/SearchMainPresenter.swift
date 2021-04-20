//
//  SearchMainPresenter.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/20.
//

import Foundation

class SearchMainPresenter: SearchMainPresenterProtocol {
    
    weak var view: SearchMainViewProtocol?
    var interactor: SearchMainInteractorInputProtocol?
    var wireFrame: SearchMainWireFrameProtocol?
    
    var recentSearhes: [String] = []
    var trendingGif: [String] = []
    var autoCompletes: [String] = []
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.fetchInitialElements()
    }
    
    func searchBigin(_ keyword: String) {
        interactor?.fetchAutoComplete(keyword)
    }
    
    
    // MARK: 최근 검색어 관련
    
    func numberOfRecentSearches() -> Int {
        return recentSearhes.count
    }
    
    func didSelectRecentSearches(_ indexPath: IndexPath) {
        wireFrame?.presentSearchResult()
    }
    
    func itemOfRecentSearches(_ indexPath: IndexPath) -> String {
        return recentSearhes[indexPath.row]
    }
    
    
    // MARK: 트렌디 gif 관련
    
    func numberOfTrendingGif() -> Int {
        return trendingGif.count
    }
    
    func didSelectTrendingGif(_ indexPath: IndexPath) {
        wireFrame?.presentContentDetail()
//        trendingGif[indexPath.row]
    }
    
    func itemOfTrendingGif(_ indexPath: IndexPath) -> String {
        return trendingGif[indexPath.row]
    }
    
    
    // MARK: 자동완성 관련
    
    func numberOfAutoComplete() -> Int {
        return autoCompletes.count
    }
    
    func didSelectAutoComplete(_ indexPath: IndexPath) {
        wireFrame?.presentSearchResult()
    }
    
    func itemOfAutoComplete(_ indexPath: IndexPath) -> String {
        return autoCompletes[indexPath.row]
    }
    
    // MARK: 검색 버튼 탭
    
    func searchKeyword(_ keyword: String) {
        view?.showLoading()
        wireFrame?.presentSearchResult()
    }
}
extension SearchMainPresenter: SearchMainInteractorOutputProtocol {
    func retrievedTrendingGif() {
        view?.hideLoading()
        view?.didReceiveTrendingGif()
    }
    
    func retrievedRecentSearches() {
        view?.hideLoading()
        view?.didReceiveRecentSearches()
    }
    
    func retrievedAutoComplete(_ autoCompletes: [String]) {
        view?.didReceiveAutoCompletes()
    }
    
    func onError() {
        view?.showError()
    }
}