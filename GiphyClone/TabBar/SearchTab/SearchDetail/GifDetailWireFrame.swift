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
        let localDataManager = GifDetailLocalDataManager()
        let wireFrame = GifDetailWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        presenter.gif = gif
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.localDataManager = localDataManager
        remoteDataManager.interactor = interactor
        localDataManager.interactor = interactor
        
        return view
    }
}
