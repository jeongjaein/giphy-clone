//
//  SearchMainWireFrame.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/20.
//

import UIKit

class SearchMainWireFrame: SearchMainWireFrameProtocol {

    static func createSearchMainModule() -> UIViewController {
        let view = SearchMainView()
        let presenter = SearchMainPresenter()
        let interactor = SearchMainInteractor()
        let remoteDataManager = SearchMainRemoteDataManager()
        let wireFrame = SearchMainWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        remoteDataManager.interactor = interactor
        
        return view
    }
    
    func presentSearchResult(from view: SearchMainViewProtocol,  _ keyword: String) {
        let searchResultView = SearchResultWireFrame.createSearchResultModule(keyword)
        guard let nav = (view as? UIViewController)?.navigationController else { return }
        nav.pushViewController(searchResultView, animated: false)
    }
    
    func presentContentDetail() {
        // 추후 가능 시나리오
    }
}
