//
//  AlbumDetailDataSource.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 11/24/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
//

import Foundation
import UIKit

class AlbumDetailDataSource: NSObject, UITableViewDataSource {
    private var songs: [Song]
    
    init(songs: [Song]) {
        self.songs = songs
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongCell.reuseIdentifier, for: indexPath) as! SongCell
        
        let song = songs[indexPath.row]
        let viewModel = SongViewModel(song: song)
        
        cell.songTitleLabel.text = viewModel.title
        cell.songRuntimeLabel.text = viewModel.runtime
        cell.backgroundColor = UIColor.clear
        cell.songTitleLabel.textColor = UIColor.white
        
        let bgColorView = UIView()
        let bgColor = UIColor(red: 73/255.0, green: 22/255.0, blue: 181/255.0, alpha: 1.0)
        bgColorView.backgroundColor = bgColor
        cell.selectedBackgroundView = bgColorView

        return cell
    }
    
    func song(at indexPath: IndexPath) -> Song {
        return songs[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Tracks"
        default: return nil
        }
    }
    
    func update(with songs: [Song]) {
        self.songs = songs
    }
}
