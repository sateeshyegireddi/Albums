//
//  EndPoint.swift
//  Resplash
//
//  Created by Sateesh Yemireddi on 3/2/21.
//

import Foundation

enum EndPoint: Hashable {
    //Base url
    case baseURL
    
    //Path
    case albums
    case photos
    
    //Query
    case albumId
    
    var rawValue: String {
        switch self {
        case .baseURL:
            return "https://jsonplaceholder.typicode.com/"
        case .albums:
            return "albums"
        case .photos:
            return "photos"
        case .albumId:
            return "albumId"
        }
    }
}
