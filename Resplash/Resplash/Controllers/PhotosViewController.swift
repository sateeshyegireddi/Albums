//
//  PhotosViewController.swift
//  Resplash
//
//  Created by Sateesh Yemireddi on 3/2/21.
//

import UIKit

class PhotosViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    //MARK: - Variables
    var album = Album()
    private var viewModel = PhotosViewModel()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup basic UI
        setupUI()
        
        //Setup binding UI with ViewModel
        bindDataToUI()
        
        //Get the photos data initially
        viewModel.fetchPhotos(for: album.id)
    }

    //MARK: - Helper
    private func setupUI() {
        
        //Setup NavigationBar
        self.title = album.title
        self.setDefaultSettings()
        
        //Register CollectionView
        photosCollectionView.register(cellType: PhotoCell.self)
    }
    
    private func bindDataToUI() {
        
        //Photos
        viewModel.photos.bind { [weak self] photos in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.photosCollectionView.reloadData()
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
    }
    
    //MARK: - Deinit
    deinit {
        print("\(#file): De-initialized")
    }
}

//MARK: - UICollectionView DataSource
extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: PhotoCell.self, for: indexPath)
        let photo = viewModel.photos.value[indexPath.item]
        cell.setupPhoto(photo)
        return cell
    }
}

//MARK: - UICollectionView DelegateFlowLayout
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

//MARK: - Spinner
extension PhotosViewController: ActivityPresentable {}
