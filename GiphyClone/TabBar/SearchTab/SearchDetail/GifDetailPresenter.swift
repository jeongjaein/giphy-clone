//
//  GifDetailPresenter.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import Foundation

class GifDetailPresenter: GifDetailPresenterProtocol {
    weak var view: GifDetailViewProtocol?
    var interactor: GifDetailInteractorInputProtocol?
    var wireFrame: GifDetailWireFrameProtocol?
    var gif: SearchGif?
    
    func viewDidLoad() {
        interactor?.getLikeState()
    }
    
    func getGifInfo() -> GifDetail {
        return convertToDetail(gif!)
    }
    
    func likeButtonDidTap() {
        interactor?.toggleLikeButton()
    }
}

extension GifDetailPresenter: GifDetailInteractorOutputProtocol {
    func receiveLikeButtonState(_ state: Bool) {
        view?.setLikeButton(state)
    }
}

extension GifDetailPresenter {
    func convertToDetail(_ gif: SearchGif) -> GifDetail {
        var mURL        = ""
        var pURL        = ""
        var dName       = ""
        var uName       = ""
        var iVerified   = false
        
        if let mainImageURL = gif.images?.originalStill?.url,
           let profileURL   = gif.user?.profileURL,
           let displayName  = gif.user?.displayName,
           let userName     = gif.user?.userName,
           let isVerified   = gif.user?.isVerified {
            mURL        = mainImageURL
            pURL        = profileURL
            dName       = displayName
            uName       = userName
            iVerified   = isVerified
        }
        
        let detail = GifDetail(
            mainImage: mURL,
            profileImage: pURL,
            displayName: dName,
            username: uName,
            isVerified: iVerified)
        
        return detail
    }
}
