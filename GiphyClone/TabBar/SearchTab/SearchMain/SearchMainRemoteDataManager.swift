//
//  SearchMainRemoteDataManager.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/20.
//

import Foundation

class SearchMainRemoteDataManager: SearchMainRemoteDataManagerInputProtocol {
    
    weak var interactor: SearchMainRemoteDataManagerOutputProtocol?
    
    func callTrendingGifAPI() {
        interactor?.callTrendingGifResult()
        interactor?.errorFromRemote()
    }
    
    func callAutoCompleteAPI(_ keyword: String) {
        interactor?.callAutoCompleteResult([])
        interactor?.errorFromRemote()
    }
    
}