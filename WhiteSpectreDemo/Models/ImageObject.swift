//
//  ImageObject.swift
//  WhiteSpectreDemo
//
//  Created by Alejandro Ravasio on 07/06/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation

//This is a class that can represent either Stickers or Gifs from the Giphy API.
//It shouldn't be used directly other than by Image Objects (gifs, stickers).
class ImageObject: Codable {
    
    //I dont really care for most data this GIPHY provides at this point, so I'll just hide it.
    fileprivate var data: Dictionary<String,String> = [:]
    
    //The URL for the image asset. *Technically* I should be able to force-unwrap this and it should always be a safe operation.
    //Force-unwrapping is a bad practice, and I don't trust backend developers to not mess up their own contracts,
    //so I'll define this one as optional, still.
    var url: String? {
        return data["url"]
    }
    
    private enum CodingKeys: String, CodingKey {
        case data = "original"
    }
}
