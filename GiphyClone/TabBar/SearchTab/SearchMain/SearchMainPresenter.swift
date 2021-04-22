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
    
    var listSwitch                      = false
    var searchSugession: [String]       = []
    var recentSearhes: [String]         = []
    var trendingGif: [String]           = []
    var autoCompletes: [AutoComplete]   = []
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.fetchInitialElements()
    }
    
    func searchTextFieldChanged(_ keyword: String) {
        listSwitch = !keyword.isEmpty
        view?.topTableviewReload(listSwitch
                                    ? "Search Sugession"
                                    : "Trending Searches")
        interactor?.fetchAutoComplete(keyword)
    }
    
    
    // MARK: 상위 테이블뷰 리스트
    
    func numberOfList() -> Int{
        return listSwitch
            ? autoCompletes.count
            : searchSugession.count
    }
    
    func didSelectOfList(_ indexPath: IndexPath) {
        let keyword = listSwitch
            ? autoCompletes[indexPath.row].name
            : searchSugession[indexPath.row]
        
        wireFrame?.presentSearchResult(from: view!, keyword)
    }
    
    func itemOfList(_ indexPath: IndexPath) -> (Bool, String) {
        return (listSwitch, listSwitch
                    ? autoCompletes[indexPath.row].name
                    : searchSugession[indexPath.row])
    }
    
    // MARK: 최근 검색어 관련
    
    func numberOfRecentSearches() -> Int {
        return recentSearhes.count
    }
    
    func didSelectRecentSearches(_ indexPath: IndexPath) {
        wireFrame?.presentSearchResult(from: view!, recentSearhes[indexPath.row])
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
    }
    
    func itemOfTrendingGif(_ indexPath: IndexPath) -> String {
        return trendingGif[indexPath.row]
    }
    
    // MARK: 검색 버튼 탭
    
    func searchKeyword(_ keyword: String) {
        view?.showLoading()
        interactor?.checkKeyword(keyword)
    }
}
extension SearchMainPresenter: SearchMainInteractorOutputProtocol {
    func retrivedSearchSugession(_ searchSuggesion: [String]) {
        searchSugession = Array(searchSuggesion[0..<5])
        view?.topTableviewReload(nil)
    }
    
    func retrievedAutoComplete(_ autoCompletes: [AutoComplete]) {
        self.autoCompletes = autoCompletes
        view?.topTableviewReload(nil)
    }
    
    func retrievedTrendingGif() {
        view?.hideLoading()
        view?.didReceiveTrendingGif()
    }
    
    func retrievedRecentSearches(_ searches: [String]) {
        recentSearhes = searches
        view?.hideLoading()
        view?.didReceiveRecentSearches()
    }
    
    func checkKeywordResult(_ result: Bool, _ keyword: String) {
        if result {
            recentSearhes.insert(keyword, at: 0)
            view?.didReceiveRecentSearches()
            wireFrame?.presentSearchResult(from: view!, keyword)
        } else {
            view?.showError()
        }
    }
    
    func onError() {
        view?.showError()
    }
}
