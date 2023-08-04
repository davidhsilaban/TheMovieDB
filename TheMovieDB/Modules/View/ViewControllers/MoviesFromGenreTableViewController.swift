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
    private var displayedMovies: [MoviesByGenreResultsModel] = []
    private var displayedMoviePosters: [Int:UIImage?] = [:]
    private var totalMovies: Int = 0
    private var totalPages: Int = 1
    var presenter: MoviesFromGenreListViewToPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Load movies from TMDB
        guard let genreId = genreId else {
            return
        }
        MBProgressHUD.showAdded(to: self.view, animated: true)
        presenter?.updateView(genreId: genreId, page: 1)
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
            let imgView = cell.viewWithTag(1) as? UIImageView
            let label = cell.viewWithTag(2) as? UILabel
            label?.text = movieData.title
            if let movieId = movieData.id {
                imgView?.image = self.displayedMoviePosters[movieId] as? UIImage
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath)
            cell.textLabel?.text = "Loading..."
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if displayedMovies.count < totalMovies {
            if indexPath.row == displayedMovies.count {
                guard let genreId = genreId else {
                    return
                }
                presenter?.updateView(genreId: genreId, page: (indexPath.row / 20)+1)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < displayedMovies.count {
            return 300.0
        } else {
            return UITableView.automaticDimension
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
            dest.movieId = movieData.id
            dest.navigationItem.title = movieData.title ?? "Unknown Title"
            MoviePrimaryInfoRouter.createModule(view: dest)
        }
    }

}

extension MoviesFromGenreTableViewController: MoviesFromGenreListPresenterToViewProtocol {
    
    func showMoviesFromGenre() {
        self.totalMovies = presenter?.getMoviesListCount() ?? 0
        self.totalPages = presenter?.getMoviesPageTotal() ?? 0
        self.displayedMovies = presenter?.interactor?.movies ?? []
        if let total = presenter?.getMoviesListCount() {
            for i in 0..<total {
                let item = presenter?.getMovie(index: i)
                // Load movie poster
                if let movieId = item?.id {
                    if let posterPath = item?.poster_path {
                        let urlComponents = URLComponents(string: "https://image.tmdb.org/t/p/original"+posterPath)
                        if let url = urlComponents?.url {
                            if let data = try? Data(contentsOf: url) {
                                if let image = UIImage(data: data) {
                                    self.displayedMoviePosters[movieId] = image
                                } else {
                                    self.displayedMoviePosters[movieId] = UIImage(named: "no_image")
                                }
                            } else {
                                self.displayedMoviePosters[movieId] = UIImage(named: "no_image")
                            }
                        } else {
                            self.displayedMoviePosters[movieId] = UIImage(named: "no_image")
                        }
                    } else {
                        self.displayedMoviePosters[movieId] = UIImage(named: "no_image")
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func showMoviesFromGenreError() {
        MBProgressHUD.hide(for: self.view, animated: true)
        let alertVc = UIAlertController(title: "Error", message: "Unable to load movies from selected genre from TheMovieDB", preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVc, animated: true, completion: nil)
    }
}
