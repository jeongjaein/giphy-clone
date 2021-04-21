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
    var onceOnly = false
    
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
    
    func getGifInfo() -> GifDetail {
        return convertToDetail(gifs[index!])
    }
    
    func likeButtonDidTap() {
        guard let id = index,
              let gifID = gifs[id].id else { return }
        interactor?.toggleLikeButton(gifID)
    }
    
    func getOnlyOne() -> (Bool,Int) {
        guard let index = index else { return (true, 0) }
        return (onceOnly, index)
    }
    
    func toggleOnlyOne() {
        onceOnly = true
    }
    
    func setCurrentIndex(_ index: IndexPath) {
        self.index = index.row
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
