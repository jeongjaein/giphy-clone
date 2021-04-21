//
//  GifLocalDataManager.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import Foundation

class GifDetailLocalDataManager: GifDetailLocalDataManagerInputProtocol {
    weak var interactor: GifDetailLocalDataManagerOutputProtocol?
    
    func togglelikeButton() {
//        core data completion에 fetch 담자
    }
    
    func fetchLikeState() {
        //core data 갔다오자
        interactor?.currentLikeButtonState(true)
    }
}
