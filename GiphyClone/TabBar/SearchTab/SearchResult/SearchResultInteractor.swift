//
//  SearchResultInteractor.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import Foundation

class SearchResultInteractor: SearchResultInteractorInputProtocol {
    weak var presenter: SearchResultInteractorOutputProtocol?
    var remoteDataManager: SearchResultRemoteDataManagerInputProtocol?
    
    func fetchSearchGif(_ keyword: String) {
        remoteDataManager?.callSearchKeywordAPI(keyword)
    }
}

extension SearchResultInteractor: SearchResultRemoteDataManageroutputProtocol {
    func callSearchKeywordResult(_ searchGif: [SearchGif]) {
        presenter?.retrievedSearchKeyword(searchGif)
    }
    
    func onError() {
        presenter?.onError()
    }
}
