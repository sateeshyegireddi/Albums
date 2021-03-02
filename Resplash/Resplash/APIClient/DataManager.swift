//
//  DataManager.swift
//  Resplash
//
//  Created by Sateesh Yemireddi on 3/2/21.
//

import Foundation

class DataManager {}

//MARK: - Albums
protocol FetchAlbums {
    func fetchAlbums(with request: APIRequest,
                     handler: @escaping (_ albums: [Album]?, _ error: NetworkError?) -> ())
}

extension DataManager: FetchAlbums {
    func fetchAlbums(with request: APIRequest,
                            handler: @escaping (_ albums: [Album]?, _ error: NetworkError?) -> ()) {
        APIClient.send(request) { (result: Result<[Album], NetworkError>) in
            switch result {
            case .success(let albums):
                handler(albums, nil)
            case .failure(let failError):
                handler(nil, failError)
            }
        }
    }
}

//MARK: - Photos
protocol FetchPhotos {
    func fetchPhotos(with request: APIRequest,
                     handler: @escaping (_ photos: [Photo]?, _ error: NetworkError?) -> ())
}

extension DataManager: FetchPhotos {
    func fetchPhotos(with request: APIRequest,
                     handler: @escaping (_ photos: [Photo]?, _ error: NetworkError?) -> ()) {
        APIClient.send(request) { (result: Result<[Photo], NetworkError>) in
            switch result {
            case .success(let photos):
                handler(photos, nil)
            case .failure(let failError):
                handler(nil, failError)
            }
        }
    }
}
