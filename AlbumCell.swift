//
//  AlbumCell.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 11/24/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {
    
    static let reuseIdentifier = "AlbumCell"
/*
    var albumImg = UIImageView()
    var albumTitle = UILabel()
    var genreTitle = UILabel()
    var releaseTitle = UILabel()*/
    
    @IBOutlet weak var artworkView: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var genreTitle: UILabel!
    @IBOutlet weak var releaseTitle: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with viewModel: AlbumCellViewModel) {
        artworkView.image = viewModel.artwork
        albumTitle.text = viewModel.title
        genreTitle.text = viewModel.genre
        releaseTitle.text = viewModel.releaseDate
    }

}
