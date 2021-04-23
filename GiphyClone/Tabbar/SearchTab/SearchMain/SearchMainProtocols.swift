//
//  SearchMainProtocols.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/20.
//

import UIKit

protocol SearchMainViewProtocol: class {
    var presenter: SearchMainPresenterProtocol? { get set }
    
    /// TableViewList
    func topTableviewReload(_ subTitle: String?)
    
    /// RecentSearches
    func didReceiveRecentSearches()
    
    /// Common
    func showLoading()
    func hideLoading()
    func showError()
}

protocol SearchMainPresenterProtocol: class {
    var view:       SearchMainViewProtocol?             { get set }
    var interactor: SearchMainInteractorInputProtocol?  { get set }
    var wireFrame:  SearchMainWireFrameProtocol?        { get set }
    
    var listSwitch: Bool              { get set }
    var searchSugession: [String]     { get set }
    var recentSearhes: [String]       { get set }
    var autoCompletes: [AutoComplete] { get set }
    
    func viewDidLoad()
    func searchTextFieldChanged(_ keyword: String)
    
    /// TableViewList
    func numberOfList() -> Int
    func didSelectOfList(_ indexPath: IndexPath)
    func itemOfList(_ indexPath: IndexPath) -> (Bool, String)
    
    /// RecentSearches
    func numberOfRecentSearches() -> Int
    func didSelectRecentSearches(_ indexPath: IndexPath)
    func itemOfRecentSearches(_ indexPath: IndexPath) -> String
    
    /// Search
    func searchKeyword(_ keyword: String)
}

protocol SearchMainInteractorInputProtocol: class {
    var presenter:          SearchMainInteractorOutputProtocol?       { get set }
    var remoteDataManager:  SearchMainRemoteDataManagerInputProtocol? { get set }
    
    /// Init
    func fetchInitialElements()
    
    /// AutoComplete
    func fetchAutoComplete(_ keyword: String)
    
    /// RecentSearches
    func checkKeyword(_ keyword: String)
}

protocol SearchMainInteractorOutputProtocol: class {
    /// RecentSearches
    func retrievedRecentSearches(_ searches: [String])
    
    // Search Validation
    func checkKeywordResult(_ result: Bool, _ searches: String)
    
    /// AutoComplete
    func retrievedAutoComplete(_ autoCompletes: [AutoComplete])
    
    /// SearchSuggesion
    func retrivedSearchSugession(_ searchSuggesion: [String])
    
    func onError()
}

protocol SearchMainRemoteDataManagerInputProtocol: class {
    var interactor: SearchMainRemoteDataManagerOutputProtocol? { get set }
    
    /// AutoComplete
    func callAutoCompleteAPI(_ keyword: String)
    
    /// SearchSuggesion
    func callSearchSuggesionAPI()
    
    /// RandomID
    func callRandomIdAPI()
}

protocol SearchMainRemoteDataManagerOutputProtocol: class {
    /// AutoComplete
    func callAutoCompleteResult(_ autoCompletes: [AutoComplete])
    
    /// SearchSuggesion
    func callSearchSuggesionResult(_ searchSuggesionList: [String])
    
    /// RandomID
    func callRandomIdAPIResult(_ id: RandomID)
    
    func errorFromRemote()
}

protocol SearchMainWireFrameProtocol: class {
    static func createSearchMainModule() -> UIViewController
    
    func presentContentDetail()
    func presentSearchResult(from view: SearchMainViewProtocol,  _ keyword: String)
}
