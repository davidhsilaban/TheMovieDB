//
//  MoviePrimaryInfoTableViewController.swift
//  TheMovieDB
//
//  Created by David Silaban on 23/08/21.
//

import UIKit
import MBProgressHUD

class MoviePrimaryInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var movieId: Int?
    private var movieDataDict: [String:Any]?
    private var movieDataKeys: [String] = []
    private var movieDataValues: [String] = []
    private var movieDataGenres: [String] = []
    private var movieDataCompanies: [String] = []
    private var movieDataCountries: [String] = []
    private var movieDataLanguages: [String] = []
    private var movieVideos: [[String:Any]]?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Load movie info from TMDB
        MBProgressHUD.showAdded(to: self.view, animated: true)
        TMDBAPIInterface.shared.getPrimaryInfoByMovieId(movieId: movieId ?? 0) { (success, statusCode, data) in
            TMDBAPIInterface.shared.getVideosByMovieId(movieId: self.movieId ?? 0) { (success, statusCode, dataVid) in
                if let vids = dataVid?["results"] as? [[String:Any]] {
                    self.movieVideos = vids
                }
                
                DispatchQueue.global().async { [weak self] in
                    if let posterPath = data?["poster_path"] as? String {
                        let urlComponents = URLComponents(string: "https://image.tmdb.org/t/p/original"+posterPath)
//                        var theParams = ["api_key": APIHTTPRequest.API_KEY as Any]
//                        urlComponents?.queryItems = theParams.map { (key, value) in
//                            URLQueryItem(name: key, value: String(describing: value))
//                        }
                        if let url = urlComponents?.url {
                            if let data = try? Data(contentsOf: url) {
                                if let image = UIImage(data: data) {
                                    DispatchQueue.main.async {
                                        self?.imageView.image = image
                                    }
                                }
                            }
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    if let res = data {
                        self.movieDataDict = res
                        for (key, value) in Array(res).sorted(by: {$0.0 < $1.0}) {
                            self.movieDataKeys.append(key)
                            self.movieDataValues.append(String(describing: value))
                        }
                        
                        // Genres
                        if let genres = res["genres"] as? [[String:Any]] {
                            for genre in genres {
                                self.movieDataGenres.append(genre["name"] as! String)
                            }
                        }
                        
                        // Companies
                        if let companies = res["production_companies"] as? [[String:Any]] {
                            for company in companies {
                                self.movieDataCompanies.append(company["name"] as! String)
                            }
                        }
                        
                        // Countries
                        if let countries = res["production_countries"] as? [[String:Any]] {
                            for country in countries {
                                self.movieDataCountries.append(country["name"] as! String)
                            }
                        }
                        
                        // Languages
                        if let languages = res["spoken_languages"] as? [[String:Any]] {
                            for language in languages {
                                self.movieDataLanguages.append(language["name"] as! String)
                            }
                        }
                    }
                    self.tableView.reloadData()
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
        }
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 9
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
            
        case 1:
            return 1
            
        case 2:
            return movieDataKeys.count
            
        case 3:
            return movieVideos?.count ?? 0
            
        case 4:
            return movieDataGenres.count
            
        case 5:
            return movieDataCompanies.count
            
        case 6:
            return movieDataCountries.count
            
        case 7:
            return movieDataLanguages.count
            
        case 8:
            return 1
            
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)

        // Configure the cell...
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
            cell.textLabel?.text = movieDataDict?["tagline"] as? String
            
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
            cell.textLabel?.text = movieDataDict?["overview"] as? String
            
        case 2:
            cell.textLabel?.text = movieDataKeys[indexPath.row]
            cell.detailTextLabel?.text = movieDataValues[indexPath.row]
            
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "youtubeCell", for: indexPath)
            break
            
        case 4:
            cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
            cell.textLabel?.text = movieDataGenres[indexPath.row]
            break
            
        case 5:
            cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
            cell.textLabel?.text = movieDataCompanies[indexPath.row]
            break
            
        case 6:
            cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
            cell.textLabel?.text = movieDataCountries[indexPath.row]
            break
            
        case 7:
            cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
            cell.textLabel?.text = movieDataLanguages[indexPath.row]
            break
            
        case 8:
            cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath)
            break
            
        default:
            break
            
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Tagline"
            
        case 1:
            return "Overview"
            
        case 2:
            return "Primary Info"
            
        case 3:
            return "Videos"
            
        case 4:
            return "Genres"
            
        case 5:
            return "Production Companies"
            
        case 6:
            return "Production Countries"
            
        case 7:
            return "Spoken Languages"
            
        case 8:
            return "Reviews"
            
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            let videoData = movieVideos?[indexPath.row]
            let videoKey = videoData?["key"] as? String ?? ""
            if let url = URL(string: "https://youtu.be/"+videoKey) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    UIApplication.shared.openURL(url)
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
        if let dest = segue.destination as? UserReviewTableViewController {
            dest.movieId = movieId
        }
    }

}
