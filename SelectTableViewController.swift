//
//  SelectTableViewController.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 11/24/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
//

import UIKit

class SelectTableViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    let client = ItunesAPIClient()
    let dataSource = SelectResultsDataSource()

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
        //self.view.layer.insertSublayer(gradient, at: 0)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        //self.tableView.backgroundColor = UIColor.clear
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.barTintColor = UIColor.black
        searchController.searchBar.keyboardType = UIKeyboardType.default
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        searchController.searchBar.placeholder = "Artist"
        searchController.searchBar.keyboardAppearance = UIKeyboardAppearance.dark
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.dataSource = dataSource
        

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Select Artist"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.dismissSelectViewController))

    }
    
    @objc func dismissSelectViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Segue to the second view controller
        self.performSegue(withIdentifier: "AlbumSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Create a variable that you want to send
        if segue.identifier == "AlbumSegue" {

            //_ = segue.destination as! AlbumTableViewController
            //_ = destinationVC.topViewController as! AlbumTableViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                let artist = dataSource.artist(at: indexPath)
                let albumTableController = segue.destination as! AlbumTableViewController
                
                client.lookupArtist(withId: artist.id) { artist, error in
                    albumTableController.artist = artist
                    albumTableController.tableView.reloadData()
                }
            }
        }
    }
}




extension SelectTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
       // print(searchController.searchBar.text!)
        //dataSource.update(with: [Stub.artist])
        //tableView.reloadData()
        
        client.searchForArtists(withTerm: searchController.searchBar.text!) { [weak self] artists, error in
            self?.dataSource.update(with: artists)
            self?.tableView.reloadData()
        }
    }
}









// MARK: - Table view data source
/*
 override func numberOfSections(in tableView: UITableView) -> Int {
 // #warning Incomplete implementation, return the number of sections
 return 0
 }
 
 override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 // #warning Incomplete implementation, return the number of rows
 return 0
 }*/


/*
 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
 
 // Configure the cell...
 cell.textLabel?.textColor = UIColor.white // <- Changed color here
 var data = [Artist]()
 let artist = data[indexPath.row]
 cell.textLabel?.text = artist.name
 
 return cell
 }*/


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
