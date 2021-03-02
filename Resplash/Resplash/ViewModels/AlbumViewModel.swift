//
//  AlbumViewModel.swift
//  Resplash
//
//  Created by Sateesh Yemireddi on 3/2/21.
//

import Foundation

class AlbumViewModel {
    
    //MARK: - Variables
    private var albums = Dynamic<[Album]>([])
    var error = Dynamic<NetworkError?>(nil)
    var isLoading = Dynamic<Bool>(false)
    var searchResultAlbums = Dynamic<[Album]>([])
    var selectedAlbum = Dynamic<Album?>(nil)
    
    //MARK: - Init
    init(_ albums: Dynamic<[Album]> = Dynamic<[Album]>([])) {
        self.albums = albums
    }
    
    //MARK: - Listen
    func bindSearch(to text: String) {
        if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            searchResultAlbums.value = albums.value
        } else {
            let filteredAlbums = albums.value.filter { $0.title.contains(text.lowercased()) }
            searchResultAlbums.value = filteredAlbums
        }
    }
    
    func selectAlbum(at index: Int) {
        selectedAlbum.value = searchResultAlbums.value[index]
    }
}

//MARK: - Networking
extension AlbumViewModel {
    func fetchAlbums() {
        let request = AlbumRequest()
        isLoading.value = true
        DataManager().fetchAlbums(with: request) { (albums, error) in
            self.isLoading.value = false
            if let albums = albums {
                self.albums.value = albums
                self.searchResultAlbums.value = albums
            } else if let error = error {
                self.error.value = error
            }
        }
    }
}

struct AlbumRequest: APIRequest {
    var method: HTTPMethod = .GET
    var path: EndPoint = .albums
    var parameters: [EndPoint : String] = [:]
    var body: [String : Any]?
}
