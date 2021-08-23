//
//  MoviesFromGenreTableViewController.swift
//  TheMovieDB
//
//  Created by David Silaban on 23/08/21.
//

import UIKit
import MBProgressHUD

class MoviesFromGenreTableViewController: UITableViewController {
    var genreId: Int?
    private var displayedMovies: [[String:Any]] = []
    private var totalMovies: Int = 0
    private var totalPages: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Load movies from TMDB
        MBProgressHUD.showAdded(to: self.view, animated: true)
        TMDBAPIInterface.shared.getDiscoverMovies(genreId: genreId ?? 0, page: 1) { (success, statusCode, data) in
            DispatchQueue.main.async {
                self.totalMovies = data?["total_results"] as? Int ?? 0
                self.totalPages = data?["total_pages"] as? Int ?? 1
                if let res = data?["results"] as? [[String:Any]] {
                    self.displayedMovies.append(contentsOf: res)
                }
                self.tableView.reloadData()
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if displayedMovies.count < totalMovies {
            return displayedMovies.count + 1
        } else {
            return displayedMovies.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)

        // Configure the cell...
        if indexPath.row < displayedMovies.count {
            let movieData = displayedMovies[indexPath.row]
            cell.textLabel?.text = movieData["title"] as? String
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath)
            cell.textLabel?.text = "Loading..."
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if displayedMovies.count < totalMovies {
            if indexPath.row == displayedMovies.count {
                TMDBAPIInterface.shared.getDiscoverMovies(genreId: genreId ?? 0, page: (indexPath.row / 20)+1) { (success, statusCode, data) in
                    DispatchQueue.main.async {
                        self.totalMovies = data?["total_results"] as? Int ?? 0
                        self.totalPages = data?["total_pages"] as? Int ?? 1
                        if let res = data?["results"] as? [[String:Any]] {
                            self.displayedMovies.append(contentsOf: res)
                        }
                        self.tableView.reloadData()
                        MBProgressHUD.hide(for: self.view, animated: true)
                    }
                }
            }
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let dest = segue.destination as? MoviePrimaryInfoViewController {
            let cell = sender as! UITableViewCell
            let movieData = displayedMovies[tableView.indexPath(for: cell)?.row ?? 0]
            dest.movieId = movieData["id"] as? Int
            dest.navigationItem.title = movieData["title"] as? String ?? "Unknown Title"
        }
    }

}
