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
        guard let id = UserDefaults.standard.string(forKey: "id") else { return }
        _ = CoreDataManager.shared.putRecentSearches(keyword: keyword, userID: id)
    }
}

extension SearchResultInteractor: SearchResultRemoteDataManageroutputProtocol {
    func callSearchKeywordResult(_ searchGif: [SearchGif]) {
        presenter?.retrievedSearchKeyword(convertToGifDetail(searchGif))
    }
    
    func onError() {
        presenter?.onError()
    }
}

extension SearchResultInteractor {
    func convertToGifDetail(_ searchGif: [SearchGif]) -> [GifDetail] {
        var gifDetails: [GifDetail] = []
        searchGif.forEach {
            if let mainImage    = $0.images?.originalStill?.url,
               let profile      = $0.user?.avatarURL,
               let displayName  = $0.user?.displayName,
               let userName     = $0.user?.userName,
               let isVerified   = $0.user?.isVerified,
               let id           = $0.id,
               let width        = Double($0.images?.originalStill?.width ?? ""),
               let height       = Double($0.images?.originalStill?.height ?? "") {
                
                gifDetails.append(GifDetail(mainImage: mainImage,
                                            profileImage: profile,
                                            displayName: displayName,
                                            username: userName,
                                            isVerified: isVerified,
                                            id: id,
                                            width: width,
                                            height: height))
            }
            
        }
        return gifDetails
    }
}
