//
//  SearchResultWireFrame.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class SearchResultWireFrame: SearchResultWireFrameProtocol {
    static func createSearchResultModule(_ keyword: String) -> UIViewController {
        let view = SearchResultView()
        let presenter = SearchResultPresenter()
        let interactor = SearchResultInteractor()
        let remoteDataManager = SearchResultRemoteDataManager()
        let localDataManager = SearchResultLocalDataManager()
        let wireFrame = SearchResultWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        presenter.keyword = keyword
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.localDataManager = localDataManager
        remoteDataManager.interactor = interactor
        localDataManager.interactor = interactor
        
        return view
    }
    
    func presentGifDetail(from view: SearchResultViewProtocol, gif: [SearchGif],index: Int) {
        let searchResultView = GifDetailWireFrame.createGifDetailModule(gif)
        guard let nav = (view as? UIViewController)?.navigationController else { return }
        nav.pushViewController(searchResultView, animated: true)
    }
}
