//
//  SearchResultWireFrame.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

class SearchResultWireFrame: SearchResultWireFrameProtocol {
    static func createSearchResultModule() -> UIViewController {
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
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.localDataManager = localDataManager
        remoteDataManager.interactor = interactor
        localDataManager.interactor = interactor
        
        return view
    }
}
