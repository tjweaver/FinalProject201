//
//  SearchResultsViewController.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 11/23/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let queryArtistTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    let querySongTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    var artistName : String = ""
    var songName : String = ""
    private let myArray: NSArray = ["Song 1","Song 2","Song 3"]
    private var myTableView: UITableView!
    var albumView = UIImageView()
    var albumImageToDisplay = UIImage()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height/2
        
        myTableView = UITableView(frame: CGRect(x: 0, y: displayHeight, width: displayWidth, height: displayHeight))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.backgroundColor = UIColor.clear
        self.view.addSubview(myTableView)
        
        let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        let darkPurple = UIColor(red: 24/255.0, green: 18/255.0, blue: 97/255.0, alpha: 1.0)
        let gradient = CAGradientLayer()
        gradient.colors = [black.cgColor, darkPurple.cgColor]
        gradient.locations = [0.0, 0.75, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = view.frame
        self.view.layer.insertSublayer(gradient, at: 0)
        
        queryArtistTitle.center.x = self.view.center.x
        queryArtistTitle.center.y = 120
        queryArtistTitle.textAlignment = .center
        queryArtistTitle.text = artistName
        queryArtistTitle.textColor = UIColor.white
        let sfont = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
        queryArtistTitle.font = sfont
        self.view.addSubview(queryArtistTitle)
        
        
        querySongTitle.center.x = self.view.center.x
        querySongTitle.center.y = 295
        querySongTitle.textAlignment = .center
        querySongTitle.text = songName
        querySongTitle.textColor = UIColor.white
        let ifont = UIFont(name: "HelveticaNeue-MediumItalic", size: 18.0)!
        querySongTitle.font = ifont
        self.view.addSubview(querySongTitle)
        
        //let defaultAlbum = "defaultAlbum.png"
        albumView = UIImageView(image: albumImageToDisplay)
        albumView.frame = CGRect(x: 0, y: 150, width: 120, height: 120)
        view.addSubview(albumView)
        albumView.center.x = view.center.x
        
        let overlayAlbum = "album-mask.png"
        let overlayAlbumImage = UIImage(named: overlayAlbum)
        let overlayAlbumView = UIImageView(image: overlayAlbumImage!)
        overlayAlbumView.frame = CGRect(x: 0, y: 150, width: 120, height: 120)
        view.addSubview(overlayAlbumView)
        overlayAlbumView.center.x = view.center.x
        

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Results"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.dismissSearchResultsViewController))
    }
    
    @objc func dismissSearchResultsViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(myArray[indexPath.row])"
        cell.backgroundColor = UIColor.clear
        cell.textLabel!.textColor = UIColor.white
        return cell
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
