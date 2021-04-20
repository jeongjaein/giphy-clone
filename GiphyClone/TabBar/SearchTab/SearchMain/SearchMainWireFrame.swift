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
        let localDataManager = SearchMainLocalDataManager()
        let wireFrame = SearchMainWireFrame()
        
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
    
    func presentSearchResult() {
        //검색 결과로 갑시다
    }
    
    func presentContentDetail() {
        // 콘텐츠 상세로 갑시다
    }
}
