//
//  AlbumsViewController.swift
//  Resplash
//
//  Created by Sateesh Yemireddi on 3/2/21.
//

import UIKit

class AlbumsViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet private weak var albumsTableView: UITableView!
    
    //MARK: - Variables
    lazy private var searchBar = UISearchBar(frame: .zero)
    lazy private var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.tintColor = .white
        searchController.searchBar.setClearColor(.black)
        searchController.searchBar.setSearchIconColor(.black)
        searchController.searchBar.setSearchBarFieldColor(.white)
        searchController.searchBar.delegate = self
        return searchController
    }()
    private var viewModel = AlbumViewModel()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup basic UI
        setupUI()
        
        //Setup binding UI with ViewModel
        bindDataToUI()
        
        //Get the albums data initially
        viewModel.fetchAlbums()
    }

    //MARK: - Helper
    private func setupUI() {
        
        //Setup NavigationBar
        self.title = titleString
        self.setDefaultSettings()
        
        //Setup SearchBar
        navigationItem.searchController = searchController
        
        //Register TableView
        albumsTableView.register(cellType: AlbumCell.self)
        albumsTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func bindDataToUI() {
        
        //Albums
        viewModel.searchResultAlbums.bind { [weak self] albums in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.albumsTableView.reloadData()
            }
        }
        
        //Error
        viewModel.error.bind { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let error = error {
                    self.presentSimpleAlert(title: "Error", message: error.description)
                }
            }
        }
        
        //Loading
        viewModel.isLoading.bind { [weak self] (isLoading) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if isLoading {
                    self.presentActivity()
                } else {
                    self.dismissActivity()
                }
            }
        }
        
        //Selected Album
        viewModel.selectedAlbum.bind { album in
            DispatchQueue.main.async {
                Navigation.navigate(to: .photos, data: ["data": album as Any])
            }
        }
    }
    
    //MARK: - Deinit
    deinit {
        print("\(#file): De-initialized")
    }
}

//MARK: - UITableView DataSource
extension AlbumsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResultAlbums.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: AlbumCell.self, for: indexPath)
        let album = viewModel.searchResultAlbums.value[indexPath.row]
        cell.setupAlbum(album)
        return cell
    }
}

//MARK: - UITableView Delegate
extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectAlbum(at: indexPath.row)
    }
}

//MARK: - UISearchBar Delegate
extension AlbumsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        self.searchController.dismiss(animated: true, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.bindSearch(to: "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.bindSearch(to: searchBar.text!)
    }
}

//MARK: - Constants
extension AlbumsViewController {
    private var titleString: String {
        return "Albums"
    }
}

//MARK: - Spinner
extension AlbumsViewController: ActivityPresentable {}
