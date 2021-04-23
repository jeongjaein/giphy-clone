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
    
    func getLikeState(_ gifID: String ) {
        guard let userID = UserDefaults.standard.string(forKey: "id") else { return }
        let state = CoreDataManager.shared.getLikeState(gifID: gifID, userID: userID)
        self.presenter?.receiveLikeButtonState(state)
    }
    
    func toggleLikeButton(_ gifID: String) {
        guard let userID = UserDefaults.standard.string(forKey: "id") else { return }
        let state = CoreDataManager.shared.getLikeState(gifID: gifID, userID: userID)
        
        switch state {
        case true:
            unlikeGif(gifID)
        case false:
            likeGif(gifID)
        }
    }
    
    private func likeGif(_ gifID: String) {
        guard let userID = UserDefaults.standard.string(forKey: "id") else { return }
        let state = CoreDataManager.shared.likeGif(gifID: gifID, userID: userID)
        switch state {
        case true:
            self.presenter?.receiveLikeButtonState(true)
        case false:
            break
        }
    }
    
    private func unlikeGif(_ gifID: String) {
        guard let userID = UserDefaults.standard.string(forKey: "id") else { return }
        let state = CoreDataManager.shared.unlikeGif(gifID: gifID, userID: userID)
        switch state {
        case true:
            self.presenter?.receiveLikeButtonState(false)
        case false:
            break
        }
    }
}

extension GifDetailInteractor: GifDetailRetmoeDataManagerOutputProtocol {
    // 추후 확장
}
