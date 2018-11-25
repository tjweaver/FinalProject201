//
//  Main.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 11/22/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
//

import Foundation
import UIKit

class Main {
    
    static var isGuestLoggedIn = false
    static var isPlaying = false
    static var userNameLoggedIn = ""
    
    static var songTitleChosen = ""
    static var artistTitleChosen = ""
    
    static var searchAlbumArtHold = UIImage()
    
    func getGuestBool() -> Bool
    {
        print("get")
        return Main.isGuestLoggedIn
    }
    
    func setGuestBool(val: Bool)
    {
        print("set")
        Main.isGuestLoggedIn = val
    }
    
    func setUsername(name: String)
    {
        if(name == "")
        {
            Main.userNameLoggedIn = "default"
        }
        else
        {
            Main.userNameLoggedIn = name
        }
    }
    
    func getUsername() -> String
    {
        return Main.userNameLoggedIn
    }
    
    func setIsPlaying(play: Bool)
    {
        Main.isPlaying = play
    }
    
    func gettIsPlaying() -> Bool
    {
        return Main.isPlaying
    }
    
    func setArtistChosen(artist: String)
    {
        Main.artistTitleChosen = artist
    }
    
    func setSongChosen(song: String)
    {
        Main.songTitleChosen = song
    }
    
    func getArtistChosen() -> String
    {
        return Main.artistTitleChosen
    }
    
    func getSongChosen() -> String
    {
        return Main.songTitleChosen
    }
    
    func setSearchAlbumArt(art: UIImage)
    {
        Main.searchAlbumArtHold = art
    }
    
    func getSearchAlbumArt() -> UIImage
    {
        return Main.searchAlbumArtHold
    }

    
}
