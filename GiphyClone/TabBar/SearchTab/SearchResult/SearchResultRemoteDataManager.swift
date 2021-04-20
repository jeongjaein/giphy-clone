//
//  SearchResultRemoteDataManager.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import Foundation
import Alamofire

class SearchResultRemoteDataManager: SearchResultRemoteDataManagerInputProtocol {
    var interactor: SearchResultRemoteDataManageroutputProtocol?
    
    func callSearchKeywordAPI(_ keyword: String) {
        AF.request(NetworkRouter.searchGif(keyword: keyword))
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[SearchGif]>.self, from: data)
                        self.interactor?.callSearchKeywordResult(result.data)
                    } catch {
                        self.interactor?.onError()
                    }
                    
                case .failure:
                    self.interactor?.onError()
                }
            }
    }
}
