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
    var gifs: [SearchGif] = []
    var index: Int?
    
    func viewDidLoad() {
        interactor?.getLikeState()
    }
    
    func numberOfGifs() -> Int {
        return gifs.count
    }
    
    func didSelectGif(_ indexPath: IndexPath) {
//        추후에 진행
    }
    
    func itemOfGifs(_ indexPath: IndexPath) -> GifDetail {
        return convertToDetail(gifs[indexPath.row])
    }
    
    func likeButtonDidTap(_ index: IndexPath) {
        print( gifs[index.row].id)
    }
    
    func getGifInfo() -> GifDetail {
        return convertToDetail(gifs[index!])
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
        let detail = GifDetail(
            mainImage: gif.images?.originalStill?.url ?? "",
            profileImage: gif.user?.avatarURL ?? "",
            displayName: gif.user?.displayName ?? "",
            username: gif.user?.userName ?? "",
            isVerified: gif.user?.isVerified ?? false)
        return detail
    }
}
