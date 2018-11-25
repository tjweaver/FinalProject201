//
//  AlbumDetailViewController.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 11/24/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UITableViewController {
    
    var artworkImage: UIImage?
    
    var album: Album? {
        didSet {
            if let album = album {
                configure(with: album)
                dataSource.update(with: album.songs)
                tableView.reloadData()
            }
        }
    }
    
    var dataSource = AlbumDetailDataSource(songs: [])
    
    @IBOutlet weak var artworkView: UIImageView!
    @IBOutlet weak var genreTitle: UILabel!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var releaseTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let album = album {
            configure(with: album)
        }

        tableView.dataSource = dataSource
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissAlbumDetailViewController))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let destinationVC = segue.destination as! SearchViewController
        //destinationVC.artistNameField.text =
    }
    
    @objc func dismissAlbumDetailViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configure(with album: Album) {
        let viewModel = AlbumDetailViewModel(album: album)
        
        // Add implementation for artworkView
        //artworkView.image = album.artwork
        artworkView.image = artworkImage
        albumTitle.text = viewModel.title
        genreTitle.text = viewModel.genre
        releaseTitle.text = viewModel.releaseDate
    }
    
    
    
    
}
