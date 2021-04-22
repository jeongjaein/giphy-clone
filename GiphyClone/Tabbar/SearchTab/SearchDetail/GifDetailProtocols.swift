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
    var view:       GifDetailViewProtocol?            { get set }
    var interactor: GifDetailInteractorInputProtocol? { get set }
    var wireFrame:  GifDetailWireFrameProtocol?       { get set }
    
    func viewDidLoad()
    
    func numberOfGifs() -> Int
    func didSelectGif(_ indexPath: IndexPath)
    func itemOfGifs(_ indexPath: IndexPath) -> GifDetail
    func likeButtonDidSet()
    
    func getGifInfo() -> GifDetail
    func likeButtonDidTap()
    func getOnlyOne() -> (Bool,Int)
    func toggleOnlyOne()
    func setCurrentIndex(_ index: IndexPath)
}

protocol GifDetailInteractorInputProtocol: class {
    var presenter:         GifDetailInteractorOutputProtocol?       { get set }
    var remoteDataManager: GifDetailRemoteDataManagerInputProtocol? { get set }
    
    func toggleLikeButton(_ gifID: String)
    func getLikeState(_ gifID: String )
}

protocol GifDetailInteractorOutputProtocol: class {
    func receiveLikeButtonState(_ state: Bool)
}

protocol GifDetailRemoteDataManagerInputProtocol: class {
    var interactor: GifDetailRetmoeDataManagerOutputProtocol? { get set }
}

protocol GifDetailRetmoeDataManagerOutputProtocol: class {
    
}

protocol GifDetailWireFrameProtocol: class {
    static func createGifDetailModule(_ gif: [GifDetail], index: Int) -> UIViewController
}
