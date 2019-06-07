//
//  GIF+Api.swift
//  WhiteSpectreDemo
//
//  Created by Alejandro Ravasio on 06/06/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import Moya


// Giphy supports gifs and stickers. This enum aims to map that.
enum AssetType: String {
    case gif = "gifs"
    case sticker = "stickers"
}


enum AssetRequest: TargetType {
    //I just need to fetch gifs, so this is a very small enum.
    case search(type: AssetType, criteria: String, page: Int)
    
    var resultsMaxSize: Int {
        return 20
    }
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.giphy.com/v1") else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .search(let type,_,_):
            return "/\(type.rawValue)/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .search(_, let criteria, let page):
            return ["q": criteria,
                    "limit": resultsMaxSize,
                    "offset": page * resultsMaxSize,
                    "api_key": API.apiKey]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .search:
            return URLEncoding.queryString
        }
    }
    
    var task: Task {
        switch self {
        case .search:
            return .requestParameters(parameters: self.parameters ?? [:], encoding: self.parameterEncoding)
        }
    }
    
    /// Giphy uses query strings, so headers will just be nil.
    var headers: [String : String]? { return nil }
    
    /// sampleData is the way Moya helps streamlines mocking of data. For now we'll just return Data(). If time allows for it, we can eventually implement this.
    var sampleData: Data { return Data() }
}
