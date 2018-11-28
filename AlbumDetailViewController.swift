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
    var URLHold: String = ""
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
        
        let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        let darkPurple = UIColor(red: 24/255.0, green: 18/255.0, blue: 97/255.0, alpha: 1.0)
        let gradient = CAGradientLayer()
        gradient.colors = [black.cgColor, darkPurple.cgColor]
        gradient.locations = [0.0, 0.75, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = tableView.bounds
        let backgroundView = UIView(frame: tableView.bounds)
        backgroundView.layer.insertSublayer(gradient, at: 0)
        tableView.backgroundView = backgroundView
        
        albumTitle.textColor = UIColor.white
        
        
        if let album = album {
            configure(with: album)
        }
        
        URLHold = URLHold.replacingOccurrences(of: "100x100bb.jpg", with: "200x200bb.jpg")
        print("CAUGHT URL: "+URLHold)
        tableView.dataSource = dataSource
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissAlbumDetailViewController))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        //let destinationVC = segue.destination as! SearchViewController
        //print("YEEEEEET")
        
        //destinationVC.artistNameField.text =
    }
    
    @objc func dismissAlbumDetailViewController() {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            let selectedSong = dataSource.song(at: selectedIndexPath)
            print(selectedSong.name)
            Main().setSongChosen(song: selectedSong.name)
            print(album!.artistName)
            Main().setArtistChosen(artist: album!.artistName)
        }
        
        
        if let url = URL(string: URLHold) {
            downloadImage(from: url)
        }
        
        self.dismiss(animated: true, completion: nil)
        
        print("YEEEEEET")

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
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                Main().setSearchAlbumArt(art: UIImage(data: data)!)
            }
        }
    }
    
    
}

extension UIImageView {
    
    func setImageFromURl(stringImageUrl url: String){
        
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}
