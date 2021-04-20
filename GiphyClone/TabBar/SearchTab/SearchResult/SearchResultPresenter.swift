//
//  SearchResultPresenter.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import Foundation

class SearchResultPresenter: SearchResultPresenterProtocol {
    
    
    var view: SearchResultViewProtocol?
    var interactor: SearchResultInteractorInputProtocol?
    var wireFrame: SearchResultWireFrameProtocol?
    
    var keyword: String = ""
    var searchGif: [SearchGif] = []
    
    func viewDidLoad() {
        interactor?.fetchSearchGif(keyword)
    }
    
    func searchButtonDidTap(_ keyword: String) {
        interactor?.fetchSearchGif(keyword)
    }
    
    // MARK: SearchGif 관련
    
    func numberOfSearchGif() -> Int {
        return searchGif.count
    }
    
    func didSelectSearchGif(_ indexPath: IndexPath) {
        let selectedGif = searchGif[indexPath.row]
    }
    
    func itemOfSearchGif(_ indexPath: IndexPath) -> Data {
        let gif = searchGif[indexPath.row]
        guard let url = URL(string: gif.images!.originalStill!.url!)
        else { return Data() }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch { }
        return Data()
    }
    
    func getGifImage(_ indexPath: IndexPath) -> Data {
        let gif = searchGif[indexPath.row]
        guard let url = URL(string: gif.images!.originalStill!.url!)
        else { return Data() }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch { }
        return Data()
    }
}

extension SearchResultPresenter: SearchResultInteractorOutputProtocol {
    func retrievedSearchKeyword(_ searchGif: [SearchGif]) {
        self.searchGif = searchGif
        view?.hideLoading()
        view?.didReceiveSearchGif()
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
}