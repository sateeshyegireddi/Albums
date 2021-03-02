//
//  PhotoCell.swift
//  Resplash
//
//  Created by Sateesh Yemireddi on 3/2/21.
//

import UIKit
import SDWebImage

class PhotoCell: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    //MARK: - Setup
    func setupPhoto(_ photo: Photo) {
        titleLabel.text = photo.title
        photoImageView.sd_setImage(with: URL(string: photo.url),
                                   placeholderImage: UIImage(named: "placeholder"))
    }
}
