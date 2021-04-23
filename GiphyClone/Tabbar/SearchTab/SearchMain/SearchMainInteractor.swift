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
        remoteDataManager?.callSearchSuggesionAPI()
        if UserDefaults.standard.object(forKey: "id") == nil {
            remoteDataManager?.callRandomIdAPI()
        } else {
            getRecentSearches()
        }
    }
    
    func fetchAutoComplete(_ keyword: String) {
        remoteDataManager?.callAutoCompleteAPI(keyword)
    }
    
    func checkKeyword(_ keyword: String) {
        guard let id = UserDefaults.standard.string(forKey: "id") else { return }
        if keyword.isEmpty {
            presenter?.checkKeywordResult(false,keyword)
        } else {
            let putKeyword =
                CoreDataManager.shared.putRecentSearches(keyword: keyword, userID: id)
            if !putKeyword.isEmpty {
                presenter?.checkKeywordResult(true,keyword)
            } else {
                presenter?.checkKeywordResult(false, keyword)
            }
        }
    }
}

extension SearchMainInteractor: SearchMainRemoteDataManagerOutputProtocol {
    
    func callAutoCompleteResult(_ autoCompletes: [AutoComplete]) {
        presenter?.retrievedAutoComplete(autoCompletes)
    }
    
    func errorFromRemote() {
        presenter?.onError()
    }
    
    func callRandomIdAPIResult(_ id: RandomID) {
        UserDefaults.standard.set(id.id, forKey: "id")
    }
    
    func callSearchSuggesionResult(_ searchSuggesionList: [String]) {
        presenter?.retrivedSearchSugession(searchSuggesionList)
    }
}

extension SearchMainInteractor {
    
    func getRecentSearches() {
        guard let userID = UserDefaults.standard.string(forKey: "id") else { return }
        let recentSearches = CoreDataManager.shared.getRecentSearches(userID: userID)
        presenter?.retrievedRecentSearches(recentSearches)
    }
}
