//
//  SearchMainProtocols.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/20.
//

import UIKit

protocol SearchMainViewProtocol: class {
    var presenter: SearchMainPresenterProtocol? { get set }
    
    func didReceiveTrendingGif()
    func didReceiveRecentSearches()
    func didReceiveAutoCompletes()
    
    func showLoading()
    func hideLoading()
    func showError()
}

protocol SearchMainPresenterProtocol: class {
    var view:       SearchMainViewProtocol? { get set }
    var interactor: SearchMainInteractorInputProtocol? { get set }
    var wireFrame:  SearchMainWireFrameProtocol? { get set }
    var recentSearhes: [String] { get set }
    var trendingGif: [String] { get set }
    var autoCompletes: [AutoComplete] { get set }
    
    func viewDidLoad()
    func searchTextFieldChanged(_ keyword: String)
    
    /// RecentSearches
    func numberOfRecentSearches() -> Int
    func didSelectRecentSearches(_ indexPath: IndexPath)
    func itemOfRecentSearches(_ indexPath: IndexPath) -> String
    
    /// TrendingGif
    func numberOfTrendingGif() -> Int
    func didSelectTrendingGif(_ indexPath: IndexPath)
    func itemOfTrendingGif(_ indexPath: IndexPath) -> String
    
    /// AutoComplete
    func numberOfAutoComplete() -> Int
    func didSelectAutoComplete(_ indexPath: IndexPath)
    func itemOfAutoComplete(_ indexPath: IndexPath) -> String
    
    /// Search
    func searchKeyword(_ keyword: String)
}

protocol SearchMainInteractorInputProtocol: class {
    var presenter:          SearchMainInteractorOutputProtocol? { get set }
    var remoteDataManager:  SearchMainRemoteDataManagerInputProtocol? { get set }
    
    /// Init
    func fetchInitialElements()
    
    /// AutoComplete
    func fetchAutoComplete(_ keyword: String)
    
    /// RecentSearches
    func checkKeyword(_ keyword: String)
}

protocol SearchMainInteractorOutputProtocol: class {
    /// TrendingGif
    func retrievedTrendingGif()
    
    /// RecentSearches
    func retrievedRecentSearches(_ searches: [String])
    func checkKeywordResult(_ result: Bool, _ searches: String)
    
    /// AutoComplete
    func retrievedAutoComplete(_ autoCompletes: [AutoComplete])
    
    func onError()
}

protocol SearchMainRemoteDataManagerInputProtocol: class {
    var interactor: SearchMainRemoteDataManagerOutputProtocol? { get set }
    
    /// RecentSearches
    func callTrendingGifAPI()
    
    /// AutoComplete
    func callAutoCompleteAPI(_ keyword: String)
    
    /// RandomID
    func callRandomIdAPI()
}

protocol SearchMainRemoteDataManagerOutputProtocol: class {
    /// TrendingGif
    func callTrendingGifResult()
    
    /// AutoComplete
    func callAutoCompleteResult(_ autoCompletes: [AutoComplete])
    
    /// RandomID
    func callRandomIdAPIResult(_ id: RandomID)
    
    func errorFromRemote()
}

protocol SearchMainWireFrameProtocol: class {
    static func createSearchMainModule() -> UIViewController
    
    func presentContentDetail()
    func presentSearchResult(from view: SearchMainViewProtocol,  _ keyword: String)
}
