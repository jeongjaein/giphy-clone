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
    
    /// SearchGif
    func numberOfSearchGif() -> Int
    func didSelectSearchGif(_ indexPath: IndexPath)
    func itemOfSearchGif(_ indexPath: IndexPath) -> Data
    
    func viewDidLoad()
    func searchButtonDidTap(_ keyword: String)
    func getGifImage(_ indexPath: IndexPath) -> String
}

protocol SearchResultInteractorInputProtocol: class {
    var presenter:          SearchResultInteractorOutputProtocol? { get set }
    var remoteDataManager:  SearchResultRemoteDataManagerInputProtocol? { get set }
    var localDataManager:   SearchResultLocalDataManagerInputProtocol? { get set }
    
    /// SearchKeyword
    func fetchSearchGif(_ keyword: String)
}

protocol SearchResultInteractorOutputProtocol: class {
    
    /// SearchKeyword
    func retrievedSearchKeyword(_ searchGif: [SearchGif])
    func onError()
}

protocol SearchResultRemoteDataManagerInputProtocol: class {
    var interactor: SearchResultRemoteDataManageroutputProtocol? { get set }
    /// SearchKeyword
    func callSearchKeywordAPI(_ keyword: String)
}

protocol SearchResultRemoteDataManageroutputProtocol: class {
    
    /// SearchKeyword
    func callSearchKeywordResult(_ searchGif: [SearchGif])
    func onError()
}

protocol SearchResultLocalDataManagerInputProtocol: class {
    var interactor: SearchResultLocalDataManagerOutputProtocol? { get set }
}

protocol SearchResultLocalDataManagerOutputProtocol: class {
    
}

protocol SearchResultWireFrameProtocol: class {
    static func createSearchResultModule(_ keyword: String) -> UIViewController
    func presentGifDetail(from view: SearchResultViewProtocol, gif: [SearchGif], index: Int)
}



