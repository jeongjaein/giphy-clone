//
//  GifDetailInteractor.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import Foundation

class GifDetailInteractor: GifDetailInteractorInputProtocol {
    weak var presenter: GifDetailInteractorOutputProtocol?
    var remoteDataManager: GifDetailRemoteDataManagerInputProtocol?
    var localDataManager: GifDetailLocalDataManagerInputProtocol?
    
    func getLikeState() {
        localDataManager?.fetchLikeState()
    }
    
    func toggleLikeButton(_ gifID: String) {
        localDataManager?.togglelikeButton(gifID)
    }
}

extension GifDetailInteractor: GifDetailRetmoeDataManagerOutputProtocol {
    
}

extension GifDetailInteractor: GifDetailLocalDataManagerOutputProtocol {
    func currentLikeButtonState(_ state: Bool) {
        presenter?.receiveLikeButtonState(state)
    }
}
