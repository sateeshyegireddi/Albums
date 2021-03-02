//
//  AlbumCell.swift
//  Resplash
//
//  Created by Sateesh Yemireddi on 3/2/21.
//

import UIKit

class AlbumCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    
    //MARK: - Setup
    func setupAlbum(_ album: Album) {
        titleLabel.text = album.title
    }
}
