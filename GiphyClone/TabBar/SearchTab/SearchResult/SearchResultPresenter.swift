//
//  SearchResultPresenter.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import Foundation
import UIKit

class SearchResultPresenter: SearchResultPresenterProtocol {
    
    weak var view: SearchResultViewProtocol?
    var interactor: SearchResultInteractorInputProtocol?
    var wireFrame: SearchResultWireFrameProtocol?
    
    var pagingIndex                = 0
    var keyword: String            = ""
    var gifList: [GifDetail]       = []
    var totalGifs: [GifDetail]     = []
    var imageHeightList: [CGSize] = []
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.fetchSearchGif(self.keyword)
    }
    
    func searchButtonDidTap(_ keyword: String) {
        view?.showLoading()
        interactor?.fetchSearchGif(keyword)
    }
    
    // MARK: SearchGif 관련
    
    func numberOfSearchGif() -> Int {
        return gifList.count
    }
    
    func didSelectSearchGif(_ indexPath: IndexPath) {
        wireFrame?.presentGifDetail(from: view!, gif: gifList, index: indexPath.row)
    }
    
    func getGifImage(_ indexPath: IndexPath) -> String {
        return gifList[indexPath.row].mainImage
    }
    
    func getImageHeightList() -> [CGSize] {
        return imageHeightList
    }
}

extension SearchResultPresenter: SearchResultInteractorOutputProtocol {
    func retrievedSearchKeyword(_ searchGif: [GifDetail]) {
        gifList = searchGif
        imageHeightList = gifList.map { CGSize(width: $0.width, height: $0.height) }
        pagingIndex = gifList.count
        view?.hideLoading()
        view?.didReceiveSearchGif()
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
}
