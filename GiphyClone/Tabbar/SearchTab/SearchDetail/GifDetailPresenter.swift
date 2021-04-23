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
    
    var gifs: [GifDetail]   = []
    var onceOnly            = false
    var index: Int?
    
    func viewDidLoad() {
        // 추후 확장
    }
    
    func didSelectGif(_ indexPath: IndexPath) {
        // 추후 확장
    }
    
    func numberOfGifs() -> Int {
        return gifs.count
    }
    
    func likeButtonDidSet() {
        guard let index = index else { return }
        interactor?.getLikeState(gifs[index].id )
    }
    
    func itemOfGifs(_ indexPath: IndexPath) -> GifDetail {
        return gifs[indexPath.row]
    }
    
    func getGifInfo() -> GifDetail {
        return gifs[index!]
    }
    
    func likeButtonDidTap() {
        guard let id = index else { return }
        interactor?.toggleLikeButton(gifs[id].id)
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
        view?.setView()
    }
}

extension GifDetailPresenter: GifDetailInteractorOutputProtocol {
    func receiveLikeButtonState(_ state: Bool) {
        view?.setLikeButton(state)
    }
}
