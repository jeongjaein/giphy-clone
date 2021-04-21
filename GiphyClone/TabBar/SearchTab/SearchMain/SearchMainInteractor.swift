//
//  SearchMainInteractor.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/20.
//

import Foundation

class SearchMainInteractor: SearchMainInteractorInputProtocol {
   
    weak var presenter: SearchMainInteractorOutputProtocol?
    var remoteDataManager: SearchMainRemoteDataManagerInputProtocol?
    
    func fetchInitialElements() {
        remoteDataManager?.callTrendingGifAPI()
        if UserDefaults.standard.object(forKey: "id") == nil {
            remoteDataManager?.callRandomIdAPI()
        }
    }
    
    func fetchAutoComplete(_ keyword: String) {
        remoteDataManager?.callAutoCompleteAPI(keyword)
    }
}

extension SearchMainInteractor: SearchMainRemoteDataManagerOutputProtocol {
    
    func callTrendingGifResult() {
        presenter?.retrievedTrendingGif()
    }
    
    func callAutoCompleteResult(_ autoCompletes: [AutoComplete]) {
        presenter?.retrievedAutoComplete(autoCompletes)
    }
    
    func errorFromRemote() {
        presenter?.onError()
    }
    
    func callRandomIdAPIResult(_ id: RandomID) {
        UserDefaults.standard.set(id.id, forKey: "id")
    }
}
