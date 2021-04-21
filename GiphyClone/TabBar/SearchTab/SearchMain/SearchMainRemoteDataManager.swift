//
//  SearchMainRemoteDataManager.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/20.
//

import Foundation
import Alamofire

class SearchMainRemoteDataManager: SearchMainRemoteDataManagerInputProtocol {
    
    weak var interactor: SearchMainRemoteDataManagerOutputProtocol?
    
    func callTrendingGifAPI() {
        interactor?.callTrendingGifResult()
        interactor?.errorFromRemote()
    }
    
    func callAutoCompleteAPI(_ keyword: String) {
        AF.request(NetworkRouter.autoComplete(keyword: keyword))
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder()
                            .decode(BaseResponse<[AutoComplete]>.self, from: data)
                        
                        self.interactor?.callAutoCompleteResult(result.data)
                    } catch {
                        self.interactor?.errorFromRemote()
                    }
                case .failure:
                    self.interactor?.errorFromRemote()
                }
            }
        interactor?.errorFromRemote()
    }
    
}
