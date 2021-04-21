//
//  NetworkRouter.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import Alamofire

enum NetworkRouter: URLRequestConvertible {
    
    typealias Parameters = [String: Any]
    
    // MARK: Case
    
    case autoComplete       (keyword: String)
    case searchGif          (keyword: String)
    case createRandomID
    
    // MARK: Method
    
    var method: HTTPMethod {
        switch self {
        case .autoComplete:
            return .get
        case .searchGif:
            return .get
        case .createRandomID:
            return .get
        }
    }
    
    // MARK: EndPoint
    
    var endPoint: String {
        switch self {
        case .autoComplete:
            return "/gifs/search/tags"
        case .searchGif:
            return "/gifs/search"
        case .createRandomID:
            return "/randomid"
        }
    }
    
    // MARK: Parameters
    
    var parameters: Parameters? {
        switch self {
        case let .autoComplete(keyword):
            return ["q": keyword]
        case let .searchGif(keyword):
            return ["q": keyword]
        case .createRandomID:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let baseURL = try AppConfiguration.BASE_URL.asURL()
        var params = parameters
        params?.updateValue(AppConfiguration.REST_API_KEY, forKey: "api_key")
        
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        
        request.method = method
        
        switch method {
        case .get:
            request = try URLEncoding.default.encode(request, with: params)
        case .post, .put, .delete:
            request = try JSONEncoding.default.encode(request, with: params)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        default:
            break
        }
        
        return request
    }
}

