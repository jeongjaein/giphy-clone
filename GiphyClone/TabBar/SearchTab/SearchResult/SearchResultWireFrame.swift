//
//  SearchResultWireFrame.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class SearchResultWireFrame: SearchResultWireFrameProtocol {
    static func createSearchResultModule(_ keyword: String) -> UIViewController {
        let view              = SearchResultView()
        let presenter         = SearchResultPresenter()
        let interactor        = SearchResultInteractor()
        let remoteDataManager = SearchResultRemoteDataManager()
        let wireFrame         = SearchResultWireFrame()
        
        view.presenter               = presenter
        presenter.view               = view
        presenter.interactor         = interactor
        presenter.wireFrame          = wireFrame
        interactor.presenter         = presenter
        interactor.remoteDataManager = remoteDataManager
        remoteDataManager.interactor = interactor
        
        presenter.keyword            = keyword
        
        return view
    }
    
    func presentGifDetail(from view: SearchResultViewProtocol, gif: [SearchGif],index: Int) {
        let searchResultView = GifDetailWireFrame.createGifDetailModule(gif, index: index)
        guard let nav = (view as? UIViewController)?.navigationController else { return }
        nav.pushViewController(searchResultView, animated: true)
    }
}
