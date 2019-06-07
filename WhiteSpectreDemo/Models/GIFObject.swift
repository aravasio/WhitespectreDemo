//
//  GIF.swift
//  Demo
//
//  Created by Alejandro Ravasio on 07/06/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation

/// This class models a Gif object.
/// This class works as a specification of the ImageObject, since either
/// Sticker or Gif structures from Giphy can independently change/deviate from each other.
class GIFObject: Codable {
    
    //This is the actual object from the backend. Given how this can also represent Stickers,
    //we hide its abstraction from usage and we provide an interface through the `url` property
    //to expose just that.
    fileprivate var image: ImageObject
    
    //The url String? to the image asset.
    var url: String? {
        return image.url
    }
    
    private enum CodingKeys: String, CodingKey {
        case image = "images"
    }
}

