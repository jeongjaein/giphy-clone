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
    
    var keyword: String = ""
    var totalGifs: [GifDetail] = []
    var visibleGifs: [GifDetail] = []
    var pagingIndex = 0
    var imageHeightList: [CGFloat] = [] {
        didSet {
            print("세팅됨\(imageHeightList)")
        }
    }
    
    func viewDidLoad() {
        view?.showLoading()
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactor?.fetchSearchGif(self!.keyword)
        }
    }
    
    func searchButtonDidTap(_ keyword: String) {
        view?.showLoading()
        interactor?.fetchSearchGif(keyword)
    }
    
    // MARK: SearchGif 관련
    
    func numberOfSearchGif() -> Int {
        return visibleGifs.count
    }
    
    func didSelectSearchGif(_ indexPath: IndexPath) {
        //        wireFrame?.presentGifDetail(from: view!, gif: totalGifs, index: indexPath.row)
        wireFrame?.presentGifDetail(from: view!, gif: visibleGifs, index: indexPath.row)
    }
    
    func getGifImage(_ indexPath: IndexPath) -> String {
        return visibleGifs[indexPath.row].mainImage
    }
    
    func itemOfSearchGif(_ indexPath: IndexPath) -> Data {
        do {
            guard let url = URL(string: visibleGifs[indexPath.row].mainImage) else { return Data()}
            let data = try Data(contentsOf: url)
            
            return data
        } catch {
            
        }
        return Data()
    }
    
    func preFetching(_ indexPaths: [IndexPath]) {
        if pagingIndex != totalGifs.count - 1 {
            indexPaths.forEach {
                if $0.row == pagingIndex - 1 {
                    let index = min(totalGifs.count, pagingIndex + 10)
                    visibleGifs.append(contentsOf: Array(totalGifs[pagingIndex..<index]))
                    pagingIndex = index
                    view?.reloadItems()
                }
            }
        }
    }
    
    func getImageHeightList() -> [CGFloat] {
        print("가져감")
        return imageHeightList
    }
}

extension SearchResultPresenter: SearchResultInteractorOutputProtocol {
    func retrievedSearchKeyword(_ searchGif: [GifDetail]) {
        //        totalGifs = searchGif
        //        visibleGifs = Array(searchGif[0..<min(searchGif.count, 10)])
        visibleGifs = searchGif
        imageHeightList = visibleGifs.map { CGFloat($0.height) }
        pagingIndex = visibleGifs.count
        view?.hideLoading()
        view?.didReceiveSearchGif()
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
}
