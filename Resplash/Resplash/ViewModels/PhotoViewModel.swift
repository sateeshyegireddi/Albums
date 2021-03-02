//
//  PhotoViewModel.swift
//  Resplash
//
//  Created by Sateesh Yemireddi on 3/2/21.
//

import Foundation

class PhotosViewModel {
    
    //MARK: - Variables
    var photos = Dynamic<[Photo]>([])
    var error = Dynamic<NetworkError?>(nil)
    var isLoading = Dynamic<Bool>(false)
    
    //MARK: - Init
    init(_ photos: Dynamic<[Photo]> = Dynamic<[Photo]>([])) {
        self.photos = photos
    }
}

//MARK: - Networking
extension PhotosViewModel {
    func fetchPhotos(for id: Int) {
        let request = PhotosRequest(parameters: [.albumId: "\(id)"])
        isLoading.value = true
        DataManager().fetchPhotos(with: request) { (photos, error) in
            self.isLoading.value = false
            if let photos = photos {
                self.photos.value = photos
            } else if let error = error {
                self.error.value = error
            }
        }
    }
}

struct PhotosRequest: APIRequest {
    var method: HTTPMethod = .GET
    var path: EndPoint = .photos
    var parameters: [EndPoint : String]
    var body: [String : Any]?
}
