//
//  SearchMainPresenter.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/20.
//

import Foundation

class SearchMainPresenter: SearchMainPresenterProtocol {
    var view: SearchMainViewProtocol?
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
    
    // MARK: RecentSearches func
    
    func numberOfRecentSearches() -> Int {
        return recentSearhes.count
    }
    
    func didSelectRecentSearches(_ indexPath: IndexPath) {
//        검색
//        recentSearhes[indexPath.row]
    }
    
    func itemOfRecentSearches(_ indexPath: IndexPath) -> String {
        return recentSearhes[indexPath.row]
    }
    
    // MARK: TrendingGif func
    
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
    
    // MARK: AutoComplete func
    
    func numberOfAutoComplete() -> Int {
        return autoCompletes.count
    }
    
    func didSelectAutoComplete(_ indexPath: IndexPath) {
//        검색
//        autoCompletes[indexPath.row]
    }
    
    func itemOfAutoComplete(_ indexPath: IndexPath) -> String {
        return autoCompletes[indexPath.row]
    }
    
    func searchKeyword(_ keyword: String) {
        view?.showLoading()
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
