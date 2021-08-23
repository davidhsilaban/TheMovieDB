//
//  UserReviewTableViewController.swift
//  TheMovieDB
//
//  Created by David Silaban on 23/08/21.
//

import UIKit
import MBProgressHUD

class UserReviewTableViewController: UITableViewController {
    var movieId: Int?
    private var reviews: [[String:Any]]?
    private var totalReviews: Int = 0
    private var totalPages: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Load movie reviews from TMDB
        MBProgressHUD.showAdded(to: self.view, animated: true)
        TMDBAPIInterface.shared.getReviewsByMovieId(movieId: movieId ?? 0, page: 1) { (success, statusCode, data) in
            DispatchQueue.main.async {
                if let reviews = data {
                    self.reviews = reviews["results"] as? [[String:Any]]
                    self.totalReviews = reviews["total_results"] as? Int ?? 0
                    self.totalPages = reviews["total_pages"] as? Int ?? 1
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
        if reviews?.count ?? 0 < totalPages {
            return reviews?.count ?? 0 + 1
        } else {
            return reviews?.count ?? 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "userReviewCell", for: indexPath)

        // Configure the cell...
        if indexPath.row < (reviews?.count ?? 0) {
            let reviewData = reviews?[indexPath.row]
            cell.textLabel?.text = reviewData?["content"] as? String
            cell.detailTextLabel?.text = reviewData?["author"] as? String
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath)
            cell.textLabel?.text = "Loading..."
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (reviews?.count ?? 0) < totalReviews {
            if indexPath.row == (reviews?.count ?? 0) {
                TMDBAPIInterface.shared.getReviewsByMovieId(movieId: movieId ?? 0, page: (indexPath.row / 20)+1) { (success, statusCode, data) in
                    DispatchQueue.main.async {
                        if let reviews = data {
                            self.reviews = reviews["results"] as? [[String:Any]]
                            self.totalReviews = reviews["total_results"] as? Int ?? 0
                            self.totalPages = reviews["total_pages"] as? Int ?? 1
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
