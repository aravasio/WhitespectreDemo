//
//  API.swift
//  WhiteSpectreDemo
//
//  Created by Alejandro Ravasio on 06/06/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import Moya


/// Access hub to all TMDb endpoints
class API {
    
    /// NOTE: sensitive data should never be stored in either code or plist files.
    /// They are, by definition, vulnerable to binary dumps.
    /// I'm doing this to avoid the unnecesary complexity of dealing with the enclave.
    static let apiKey = "AE2SipBeEynvqxDVaT068B9ELoeQSpq6"
    
    /// Production providers. It provides no debug info on responses and is, thus, lean-oriented.
    fileprivate static let gifsProvider = MoyaProvider<AssetRequest>()
//    fileprivate static let stickerProvider = MoyaProvider<StickerRequest>()

    
    /**
     Extremely verbose providers for debugging purposes.
     Highly adviced not to use this one unless you ought to debug something or are curious what/how it works.
     */
//        fileprivate static let gifsProvider = MoyaProvider<AssetRequest>(plugins: [NetworkLoggerPlugin(verbose: true)])
    //    fileprivate static let stickerProvider = MoyaProvider<StickerRequest>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    
    // The current query is always stored here. It invalidates all previous queries.
    
    /**
     Fetch the most popular movies.
     
     - Parameters:
     - completion: code to be executed on a succesful request.
     */
    static func getGifs(for criteria: String, page: Int, completion: @escaping ([GIFObject]) -> ()) {
        
        let _ = API.fetch(provider: gifsProvider, endpoint: .search(type: .gif, criteria: criteria, page: page), returnType: GIFResponse.self, completion: { result in
            completion(result.gifs)
        })
    }
    
    
    /**
     Fetches data from a given Target using a given Moya provider.
     
     - Parameters:
     - provider: A Moya provider.
     - endpoint: A `TargetType` enum value.
     - returnType: The type the responses should be in.
     - completion: What to do after the successful response triggers.
     
     - Returns:
     - Cancellable. A Moya-specific type. It's basically a reference to the request, so that I can cancel it, if so needed.
     */
    
    fileprivate static func fetch<T: TargetType, P: MoyaProvider<T>, R: Decodable>(provider: P, endpoint: T, returnType: R.Type, completion: @escaping (R) -> ()) -> Cancellable {
        
        let currentRequest = provider.request(endpoint) { response in
            switch response {
            case let .success(result):
                do {
                    let results = try JSONDecoder().decode(returnType, from: result.data)
                    completion(results)
                } catch let error {
                    print(error)
                }
                
            case let .failure(error):
                print(error)
                // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out).  If the server responds with a 4xx or 5xx error, that
                // will be sent as a ".success"-ful response.
            }
        }
        
        return currentRequest
    }
}

