//
//  Images+ResponseModel.swift
//  WhiteSpectreDemo
//
//  Created by Alejandro Ravasio on 07/06/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation


/// The response object from the Giphy API.
/// It contains all GIFs from the response, plus some meta and pagination data.
/// Since I use neither pagination nor meta-data, those are ignored.
class GIFResponse: Codable {
    
    //The response information pertaining to the gifs themselves.
    var gifs: [GIFObject]
    
//    var pagination: PaginationObject
//    var meta: MetaObject
    
    private enum CodingKeys: String, CodingKey {
        case gifs = "data"
    }
}
