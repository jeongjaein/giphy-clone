//
//  GifWireFrame.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class GifDetailWireFrame: GifDetailWireFrameProtocol {
    static func createGifDetailModule(_ gif: [SearchGif], index: Int) -> UIViewController {
        let view              = GifDetailView()
        let presenter         = GifDetailPresenter()
        let interactor        = GifDetailInteractor()
        let remoteDataManager = GifDetailRemoteDataManager()
        let wireFrame         = GifDetailWireFrame()
        
        view.presenter               = presenter
        presenter.view               = view
        presenter.interactor         = interactor
        presenter.wireFrame          = wireFrame
        interactor.presenter         = presenter
        interactor.remoteDataManager = remoteDataManager
        remoteDataManager.interactor = interactor
        
        presenter.gifs               = gif
        presenter.index              = index
        
        return view
    }
}
