//
//  GifDetailProtocols.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

protocol GifDetailViewProtocol: class {
    var presenter: GifDetailPresenterProtocol? { get set }
    
    func setLikeButton(_ state: Bool)
    func setView()
}

protocol GifDetailPresenterProtocol: class {
    var view: GifDetailViewProtocol? { get set }
    var interactor: GifDetailInteractorInputProtocol? { get set }
    var wireFrame: GifDetailWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func getGifInfo() -> GifDetail
    func likeButtonDidTap()
}

protocol GifDetailInteractorInputProtocol: class {
    var presenter: GifDetailInteractorOutputProtocol? { get set }
    var remoteDataManager: GifDetailRemoteDataManagerInputProtocol? { get set }
    var localDataManager: GifDetailLocalDataManagerInputProtocol? { get set }
    
    func toggleLikeButton()
    func getLikeState()
}

protocol GifDetailInteractorOutputProtocol: class {
    func receiveLikeButtonState(_ state: Bool)
}

protocol GifDetailRemoteDataManagerInputProtocol: class {
    var interactor: GifDetailRetmoeDataManagerOutputProtocol? { get set }
}

protocol GifDetailRetmoeDataManagerOutputProtocol: class {
    
}

protocol GifDetailLocalDataManagerInputProtocol: class {
    var interactor: GifDetailLocalDataManagerOutputProtocol? { get set }
    
    func fetchLikeState()
    func togglelikeButton()
}

protocol GifDetailLocalDataManagerOutputProtocol: class {
    func currentLikeButtonState(_ state: Bool)
}

protocol GifDetailWireFrameProtocol: class {
    static func createGifDetailModule(_ gif: SearchGif) -> UIViewController
}
