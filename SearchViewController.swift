//
//  SecondViewController.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 10/29/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
// SEARCH

import UIKit

struct TrackList : Decodable {
    let resultCount: Int
    let results: [Track]
    
    struct Track : Decodable {
        let wrapperType: String
        let kind: String
        let artistId:  Int
        let collectionId: Int
        let trackId: Int
        let artistName: String
        let collectionName: String
        let trackName: String
        let collectionCensoredName: String
        let trackCensoredName: String
        let artistViewUrl: String
        let collectionViewUrl: String
        let trackViewUrl: String
        let previewUrl: String
        let artworkUrl30: String
        let artworkUrl60: String
        let artworkUrl100: String
        let collectionPrice: Double
        let trackPrice: Double
        let releaseDate: String
        let collectionExplicitness: String
        let trackExplicitness: String
        let discCount: Int
        let discNumber: Int
        let trackCount: Int
        let trackNumber: Int
        let trackTimeMillis: Int
        let country: String
        let currency: String
        let primaryGenreName: String
        let contentAdvisoryRating: String
        let isStreamable: Bool
        
        enum CodingKeys: String, CodingKey {
            case wrapperType = "wrapperType"
            case kind = "kind"
            case artistId = "artistId"
            case collectionId = "collectionId"
            case trackId = "trackId"
            case artistName = "artistName"
            case collectionName = "collectionName"
            case trackName = "trackName"
            case collectionCensoredName = "collectionCensoredName"
            case trackCensoredName = "trackCensoredName"
            case artistViewUrl = "artistViewUrl"
            case collectionViewUrl = "collectionViewUrl"
            case trackViewUrl = "trackViewUrl"
            case previewUrl = "previewUrl"
            case artworkUrl30 = "artworkUrl30"
            case artworkUrl60 = "artworkUrl60"
            case artworkUrl100 = "artworkUrl100"
            case collectionPrice = "collectionPrice"
            case trackPrice = "trackPrice"
            case releaseDate = "releaseDate"
            case collectionExplicitness = "collectionExplicitness"
            case trackExplicitness = "trackExplicitness"
            case discCount = "discCount"
            case discNumber = "discNumber"
            case trackCount = "trackCount"
            case trackNumber = "trackNumber"
            case trackTimeMillis = "trackTimeMillis"
            case country = "country"
            case currency = "currency"
            case primaryGenreName = "primaryGenreName"
            case contentAdvisoryRating = "contentAdvisoryRating"
            case isStreamable = "isStreamable"
        }
    }
}





class SearchViewController: UIViewController, UITextFieldDelegate {

    // chainable animator
    let searchButton = UIButton(frame: CGRect(x: 30, y: 440, width: 100, height: 100))
    //let artistNameField =  UITextField(frame: CGRect(x: 30, y: 300, width: 300, height: 40))
    //let songNameField =  UITextField(frame: CGRect(x: 30, y: 360, width: 300, height: 40))
    let searchTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    var pulsatingLayer: CAShapeLayer!
    var artistName : String = ""
    var songName : String = ""
    let client = ItunesAPIClient()
    var albumView = UIImageView()
    let selectButton = UIButton(frame: CGRect(x: 30, y: 540, width: 100, height: 100))
    
    var songChosenByUser = UILabel(frame: CGRect(x: 0, y: 0, width: 230, height: 21))
    var artistChosenByUser = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let endpoint = Itunes.search(term: "young the giant", media: .music(entity: .musicArtist, attribute: .artistTerm))
        print(endpoint.request)
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 40, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        pulsatingLayer = CAShapeLayer()
        pulsatingLayer.path = circularPath.cgPath
        pulsatingLayer.strokeColor = UIColor.white.cgColor
        pulsatingLayer.lineWidth = 10
        pulsatingLayer.fillColor = UIColor.white.cgColor
        pulsatingLayer.lineCap = CAShapeLayerLineCap.round
        pulsatingLayer.position = CGPoint(x:view.center.x,y:view.center.y)
        view.layer.addSublayer(pulsatingLayer)

        
        self.title = "Search"
        // Background visuals
        let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        let darkPurple = UIColor(red: 24/255.0, green: 18/255.0, blue: 97/255.0, alpha: 1.0)
        let gradient = CAGradientLayer()
        gradient.colors = [black.cgColor, darkPurple.cgColor]
        gradient.locations = [0.0, 0.75, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = view.frame
        self.view.layer.insertSublayer(gradient, at: 0)
        
        // Tap to search label
        
        searchTitle.center.x = self.view.center.x
        searchTitle.center.y = 120
        searchTitle.textAlignment = .center
        searchTitle.text = "Tap to search"
        searchTitle.textColor = UIColor.white
        let sfont = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
        searchTitle.font = sfont
        //self.view.addSubview(searchTitle)


        
        artistChosenByUser.center.x = self.view.center.x
        artistChosenByUser.center.y = 120
        artistChosenByUser.textAlignment = .center
        artistChosenByUser.text = "Artist"
        artistChosenByUser.textColor = UIColor.white
        artistChosenByUser.font = sfont
        self.view.addSubview(artistChosenByUser)

        songChosenByUser.center.x = self.view.center.x
        songChosenByUser.center.y = 370
        songChosenByUser.textAlignment = .center
        songChosenByUser.text = "Song"
        songChosenByUser.textColor = UIColor.white
        let ifont = UIFont(name: "HelveticaNeue-MediumItalic", size: 18.0)!
        songChosenByUser.font = ifont
        self.view.addSubview(songChosenByUser)

        
        
        
        
        
        
        // Search Button
        // Push to send query to database
        // Sends two inputs - artist name and song name to find in database
        let searchBack = UIImage(named: "Search Button")
        searchButton.setImage(searchBack , for: .normal)
        searchButton.setTitle("Test Button", for: .normal)
        searchButton.addTarget(self, action: #selector(queryAction), for: .touchUpInside)
        self.view.addSubview(searchButton)
        searchButton.center.x = view.center.x

        
        
        
        // Artist name
        /*
        artistNameField.attributedPlaceholder = NSAttributedString(string: "Artist Name",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        artistNameField.textColor = UIColor.white
        artistNameField.font = UIFont(name: "HelveticaNeue-Light", size: 15.0)!
        artistNameField.borderStyle = UITextField.BorderStyle.roundedRect
        artistNameField.autocorrectionType = UITextAutocorrectionType.no
        artistNameField.keyboardType = UIKeyboardType.default
        artistNameField.returnKeyType = UIReturnKeyType.done
        artistNameField.clearButtonMode = UITextField.ViewMode.whileEditing;
        artistNameField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        artistNameField.delegate = self
        artistNameField.backgroundColor = UIColor.clear
        artistNameField.keyboardAppearance = UIKeyboardAppearance.dark;
        artistNameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        self.view.addSubview(artistNameField)*/
        /*
        let artistBorder = CALayer()
        let width = CGFloat(2.0)
        artistBorder.borderColor = UIColor.lightGray.cgColor
        
        artistBorder.frame = CGRect(x: 0, y: artistNameField.frame.size.height - width, width: artistNameField.frame.size.width, height: artistNameField.frame.size.height)
        
        artistBorder.borderWidth = width
        artistNameField.layer.addSublayer(artistBorder)
        artistNameField.layer.masksToBounds = true*/
        
        
        // Song name
        /*
        songNameField.attributedPlaceholder = NSAttributedString(string: "Song Name",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        songNameField.textColor = UIColor.white
        songNameField.font = UIFont(name: "HelveticaNeue-Light", size: 15.0)!
        songNameField.borderStyle = UITextField.BorderStyle.roundedRect
        songNameField.autocorrectionType = UITextAutocorrectionType.no
        songNameField.keyboardType = UIKeyboardType.default
        songNameField.returnKeyType = UIReturnKeyType.done
        songNameField.clearButtonMode = UITextField.ViewMode.whileEditing;
        songNameField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        songNameField.delegate = self
        songNameField.backgroundColor = UIColor.clear
        songNameField.keyboardAppearance = UIKeyboardAppearance.dark;
        songNameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.view.addSubview(songNameField)

        let songBorder = CALayer()
        songBorder.borderColor = UIColor.lightGray.cgColor
        songBorder.frame = CGRect(x: 0, y: songNameField.frame.size.height - width, width: songNameField.frame.size.width, height: songNameField.frame.size.height)
        
        songBorder.borderWidth = width
        songNameField.layer.addSublayer(songBorder)
        songNameField.layer.masksToBounds = true*/

        let defaultAlbum = "defaultAlbum.png"
        let albumImage = UIImage(named: defaultAlbum)
        albumView = UIImageView(image: albumImage!)
        Main().setSearchAlbumArt(art: albumImage!)
        albumView.frame = CGRect(x: 0, y: 150, width: 190, height: 190)
        view.addSubview(albumView)
        albumView.center.x = view.center.x
        pulsatingLayer.position = CGPoint(x:view.center.x,y:searchButton.center.y)
        
        
        selectButton.setTitle("Select Song", for: .normal)
        selectButton.addTarget(self, action: #selector(selectSongAction), for: .touchUpInside)
        self.view.addSubview(selectButton)
        selectButton.center.x = view.center.x
        
        
        
        
        
        
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print(textField.text!)
        /*
        var jsonURLString = "http://itunes.apple.com/search?term="
        let artistTerm = artistNameField.text!
        let artistSearch = artistTerm.replacingOccurrences(of: " ", with: "+")
        let songTerm = songNameField.text!
        let songSearch = songTerm.replacingOccurrences(of: " ", with: "+")
        
        jsonURLString = jsonURLString+artistSearch+"+"+songSearch+"&entity=song"
        print("URLSTRING: "+jsonURLString)
        guard let url = URL(string: jsonURLString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data,response,err) in
            print("hello")
            guard let data = data else { return }
            //let dataString = String(data: data, encoding: .utf8)
            //print(dataString!)
            
            do {
                let trackListComplete = try
                    JSONDecoder().decode(TrackList.self, from: data)
                //print(songComplete.artworkUrl100)
                if(trackListComplete.results.count != 0)
                {
                let URLofStringFromSearch = URL(string: trackListComplete.results[0].artworkUrl100)
                let data1 = try Data(contentsOf: URLofStringFromSearch!)
                self.albumView.image = UIImage(data: data1)
                }
                
            } catch let jsonErr {
                print("Error: ", jsonErr)
            }
            
            
            }.resume()
 */
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        animatePuslatingLayer()
        
        if(Main().getArtistChosen().isEmpty == true)
        {
            artistChosenByUser.text = "Artist"
        }
        else
        {
            artistChosenByUser.text = Main().getArtistChosen()
        }
        
        if(Main().getSongChosen().isEmpty == true)
        {
            songChosenByUser.text = "Song"
        }
        else
        {
            songChosenByUser.text = Main().getSongChosen()
        }
        
        albumView.image = Main().getSearchAlbumArt()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func queryAction(sender: UIButton!) {
        print("Search query")
        artistName = artistChosenByUser.text ?? "Young the Giant"
        songName = songChosenByUser.text ?? "My Body"
        if(artistName.isEmpty == true || songName.isEmpty == true)
        {
            artistName = "Young the Giant"
            songName = "My Body"
        }
        print("artist: "+artistName)
        print("song: "+songName)
        self.performSegue(withIdentifier: "SearchSegue", sender: self)
        artistChosenByUser.text = "Artist";
        songChosenByUser.text = "Song";
        Main().setArtistChosen(artist: "")
        Main().setSongChosen(song: "")
        let defaultAlbum = "defaultAlbum.png"
        let albumImage = UIImage(named: defaultAlbum)
        Main().setSearchAlbumArt(art: albumImage!)
        albumView.image = Main().getSearchAlbumArt()
    }
    
    @objc func selectSongAction(sender: UIButton!) {
        self.performSegue(withIdentifier: "SelectSong", sender: self)

    }
    
    override func touchesBegan(_ touches:Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        //or
        self.view.endEditing(true)
        return true
    }
    
    func animatePuslatingLayer()
    {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.4
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        pulsatingLayer.add(animation, forKey: "pulsing")
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity");
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = 1.6
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        opacityAnimation.repeatCount = Float.infinity
        pulsatingLayer.add(opacityAnimation, forKey: "fading")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // Create a variable that you want to send
        if segue.identifier == "SearchSegue" {
            let songToSend : String = self.songName
            let artistToSend : String = self.artistName

            // Create a new variable to store the instance of PlayerTableViewController
            let destinationVC = segue.destination as! UINavigationController
            let targetController = destinationVC.topViewController as! SearchResultsViewController
            
            targetController.songName = songToSend
            targetController.artistName = artistToSend
            targetController.albumImageToDisplay = self.albumView.image!
        }
        else if segue.identifier == "SelectSong" {
            let destinationVC = segue.destination as! UINavigationController
            _ = destinationVC.topViewController as! SelectTableViewController
        }
    }
    
    /*
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.text!)
        //client.searchForArtists(withTerm: artistNameField.text!) { artists, error in}
        //http://itunes.apple.com/search?term=drake+god+plan&entity=song
        
        var jsonURLString = "http://itunes.apple.com/search?term="
        let artistTerm = artistNameField.text!
        let artistSearch = artistTerm.replacingOccurrences(of: " ", with: "+")
        let songTerm = songNameField.text!
        let songSearch = songTerm.replacingOccurrences(of: " ", with: "+")

        jsonURLString = jsonURLString+artistSearch+songSearch+"&entity=song"
        
        guard let url = URL(string: jsonURLString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data,response,err) in
            print("hello")
            guard let data = data else { return }
            let dataString = String(data: data, encoding: .utf8)
            print(dataString!)
            
            do {
                let songComplete = try
                    JSONDecoder().decode(Track.self, from: data)
                print(songComplete.artworkUrl100)
                let URLofStringFromSearch = URL(string: songComplete.artworkUrl100)
                let data1 = try Data(contentsOf: URLofStringFromSearch!)
                self.albumView.image = UIImage(data: data1)

            } catch let jsonErr {
                print("Error: ", jsonErr)
            }
            
            
        }.resume()

    }*/
    
    func downloadArtworkForAlbum(_ album: Album)
    {
        //let downloader = ArtworkDownloader(album: album)
    }
}



