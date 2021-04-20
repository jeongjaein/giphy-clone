//
//  SearchResultProtocols.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

protocol SearchResultViewProtocol: class {
    var presenter: SearchResultPresenterProtocol? { get set }
    
    func didReceiveSearchGif()
    func showLoading()
    func hideLoading()
    func showError()
}

protocol SearchResultPresenterProtocol: class {
    var view:       SearchResultViewProtocol? { get set }
    var interactor: SearchResultInteractorInputProtocol? { get set }
    var wireFrame:  SearchResultWireFrameProtocol? { get set }
    var keyword: String { get set }
    
    func viewDidLoad()
}

protocol SearchResultInteractorInputProtocol: class {
    var presenter:          SearchResultPresenterProtocol? { get set }
    var remoteDataManager:  SearchResultRemoteDataManagerInputProtocol? { get set }
    var localDataManager:   SearchResultLocalDataManagerInputProtocol? { get set }
    
    /// SearchKeyword
    func fetchSearchGif(_ keyword: String)
}

protocol SearchResultInteractorOutputProtocol: class {
    
    /// SearchKeyword
    func retrievedSearchKeyword()
}

protocol SearchResultRemoteDataManagerInputProtocol: class {
    var interactor: SearchResultRemoteDataManageroutputProtocol? { get set }
    /// SearchKeyword
    func callSearchKeywordAPI(_ keyword: String)
}

protocol SearchResultRemoteDataManageroutputProtocol: class {
    
    /// SearchKeyword
    func callSearchKeywordResult()
}

protocol SearchResultLocalDataManagerInputProtocol: class {
    var interactor: SearchResultLocalDataManagerOutputProtocol? { get set }
}

protocol SearchResultLocalDataManagerOutputProtocol: class {
    
}

protocol SearchResultWireFrameProtocol: class {
    static func createSearchResultModule() -> UIViewController
}



