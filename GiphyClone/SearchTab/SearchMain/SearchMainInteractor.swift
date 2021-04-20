//
//  SearchMainInteractor.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/20.
//

import Foundation

class SearchMainInteractor: SearchMainInteractorInputProtocol {
   
    var presenter: SearchMainInteractorOutputProtocol?
    var remoteDataManager: SearchMainRemoteDataManagerInputProtocol?
    var localDataManager: SearchMainLocalDataManagerInputProtocol?
    
    func fetchInitialElements() {
        remoteDataManager?.callTrendingGifAPI()
        localDataManager?.fetchRecentSearches()
    }
    
    func fetchAutoComplete(_ keyword: String) {
        //시간체크 해서 중간에 다시 들어오면 취소
        remoteDataManager?.callAutoCompleteAPI(keyword)
    }
    
    func fetchSearchGif(_ keyword: String) {
        <#code#>
    }
}

extension SearchMainInteractor: SearchMainRemoteDataManagerOutputProtocol {
    func callTrendingGifResult() {
        presenter?.retrievedTrendingGif()
    }
    
    func callAutoCompleteResult(_ autoCompletes: [String]) {
        presenter?.retrievedAutoComplete(autoCompletes)
    }
    
    func callSearchKeywordResult() {
        <#code#>
    }
    
    func errorFromRemote() {
        presenter?.onError()
    }
}

extension SearchMainInteractor: SearchMainLocalDataManagerOutputProtocol {
    func retrievedRecentSearches() {
        presenter?.retrievedRecentSearches()
    }
    
    func errorFromLocal() {
        presenter?.onError()
    }
}

