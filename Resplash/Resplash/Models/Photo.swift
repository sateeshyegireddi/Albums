//
//  Photo.swift
//  Resplash
//
//  Created by Sateesh Yemireddi on 3/2/21.
//

import Foundation

struct Photo: Codable {
    var id: Int = 0
    var albumId: Int = 0
    var title: String = ""
    var url: String = ""
}
