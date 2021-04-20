//
//  SearchMainLocalDataManager.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/20.
//

import Foundation

class SearchMainLocalDataManager: SearchMainLocalDataManagerInputProtocol {
    
    weak var interactor: SearchMainLocalDataManagerOutputProtocol?
    
    func fetchRecentSearches() {
        interactor?.retrievedRecentSearches()
        interactor?.errorFromLocal()
    }
}
