//
//  GifWireFrame.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class GifDetailWireFrame: GifDetailWireFrameProtocol {
    static func createGifDetailModule(_ gif: [SearchGif], index: Int) -> UIViewController {
        let view = GifDetailView()
        let presenter = GifDetailPresenter()
        let interactor = GifDetailInteractor()
        let remoteDataManager = GifDetailRemoteDataManager()
        let wireFrame = GifDetailWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        presenter.gifs = gif
        presenter.index = index
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        remoteDataManager.interactor = interactor
        
        return view
    }
}
