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
//    private var reviews: [[String:Any]]?
//    private var totalReviews: Int = 0
//    private var totalPages: Int = 1
    var presenter: UserReviewListViewToPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Load movie reviews from TMDB
        guard let movieId = movieId else {
            return
        }
        MBProgressHUD.showAdded(to: self.view, animated: true)
        presenter?.updateView(movieId: movieId, page: 1)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if presenter?.getUserReviewsListCount() ?? 0 < presenter?.getUserReviewsPageTotal() ?? 1 {
            return presenter?.getUserReviewsListCount() ?? 0 + 1
        } else {
            return presenter?.getUserReviewsListCount() ?? 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "userReviewCell", for: indexPath)

        // Configure the cell...
        if indexPath.row < (presenter?.getUserReviewsListCount() ?? 0) {
            let reviewData = presenter?.getUserReview(index: indexPath.row)
            cell.textLabel?.text = reviewData?.content
            cell.detailTextLabel?.text = reviewData?.author
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath)
            cell.textLabel?.text = "Loading..."
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (presenter?.getUserReviewsListCount() ?? 0) < presenter?.getUserReviewsTotal() ?? 0 {
            if indexPath.row == (presenter?.getUserReviewsListCount() ?? 0) {
                presenter?.updateView(movieId: movieId ?? 0, page: (indexPath.row / 20)+1)
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

extension UserReviewTableViewController: UserReviewListPresenterToViewProtocol {
    func showUserReviews() {
        self.tableView.reloadData()
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func showUserReviewsError() {
        MBProgressHUD.hide(for: self.view, animated: true)
        let alertVc = UIAlertController(title: "Error", message: "Unable to load movie reviews from TheMovieDB", preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVc, animated: true, completion: nil)
    }
    
    
}
