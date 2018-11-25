//
//  ArtworkDownloader.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 11/23/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
//

import Foundation
import UIKit

class ArtworkDownloader: Operation {
    let album: Album
    
    init(album: Album) {
        self.album = album
        super.init()
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        guard let url = URL(string: album.artworkUrl) else {
            return
        }
        
        let imageData = try! Data(contentsOf: url)
        
        if self.isCancelled {
            return
        }
        
        if imageData.count > 0 {
            album.artwork = UIImage(data: imageData)
            album.artworkState = .downloaded
        } else {
            album.artworkState = .failed
        }
    }
}

























