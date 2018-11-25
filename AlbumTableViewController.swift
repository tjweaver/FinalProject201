//
//  AlbumTableViewController.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 11/24/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
//

import UIKit

class AlbumTableViewController: UITableViewController {

    private struct Constants {
        
        static let AlbumCellHeight: CGFloat = 80
    
    }
    
    let client = ItunesAPIClient()
    
    var artist: Artist! {
        didSet {
            self.title = artist?.name
            dataSource.update(with: artist!.albums)
            tableView.reloadData()
        }
    }
    lazy var dataSource: AlbumListDataSource = {
        return AlbumListDataSource(albums: [], tableView: self.tableView)
    }()
    
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
        tableView.dataSource = dataSource

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "songSelectionSegue" {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let selectedAlbum = dataSource.album(at: selectedIndexPath)
                
                let albumDetailController = segue.destination as! AlbumDetailViewController
                albumDetailController.URLHold = selectedAlbum.artworkUrl
                albumDetailController.artworkImage = selectedAlbum.artwork
                client.lookupAlbum(withId: selectedAlbum.id) { album, error in
                    albumDetailController.album = album
                }
                
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.AlbumCellHeight
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
    
    /*
     override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 0
     }
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // #warning Incomplete implementation, return the number of rows
     return 0
     }
     
     
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
}
