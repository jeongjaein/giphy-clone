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
    
    func getLikeState() {
        
    }
    
    func toggleLikeButton(_ gifID: String) {
        
    }
}

extension GifDetailInteractor: GifDetailRetmoeDataManagerOutputProtocol {
    
}
