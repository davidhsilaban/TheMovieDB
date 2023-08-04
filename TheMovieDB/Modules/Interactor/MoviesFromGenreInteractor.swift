//
//  MoviesFromGenreInteractor.swift
//  TheMovieDB
//
//  Created by Jawasoft on 04/08/23.
//

import Foundation

class MoviesFromGenreInteractor: MoviesFromGenreListPresenterToInteractorProtocol {

    // MARK: - Properties
    weak var presenter: MoviesFromGenreListInteractorToPresenterProtocol?
    var movies: [MoviesByGenreResultsModel]?
    var page: Int?
    var pageTotal: Int?
    var moviesGrandTotal: Int?
    
    // MARK: - Methods
    func fetchMoviesFromGenreId(genreId: Int, page: Int) {
        TMDBAPIInterface.shared.getDiscoverMovies(genreId: genreId, page: page) { (success, statusCode, data) in
            DispatchQueue.main.async {
                if !success || !((200...299).contains(statusCode)) {
                    self.presenter?.moviesFetchFailed()
                    return
                }
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let moviesFromGenreResponse = try decoder.decode(MoviesByGenreResponseModel.self, from: data)
                    guard let movies = moviesFromGenreResponse.results else { return }
                    self.movies = movies
                    self.page = moviesFromGenreResponse.page
                    self.pageTotal = moviesFromGenreResponse.total_pages
                    self.moviesGrandTotal = moviesFromGenreResponse.total_results
                    self.presenter?.moviesFetched()
                } catch let error {
                    print(error)
                }
                
//                self.totalMovies = data?["total_results"] as? Int ?? 0
//                self.totalPages = data?["total_pages"] as? Int ?? 1
//                if let res = data?["results"] as? [[String:Any]] {
//                    for item in res {
//                        self.displayedMovies.append(item)
//                        // Load movie poster
//                        if let movieId = item["id"] as? Int {
//                            TMDBAPIInterface.shared.getPrimaryInfoByMovieId(movieId: movieId) { (success, statusCode, data) in
//                                if let posterPath = data?["poster_path"] as? String {
//                                    let urlComponents = URLComponents(string: "https://image.tmdb.org/t/p/original"+posterPath)
//                                    if let url = urlComponents?.url {
//                                        if let data = try? Data(contentsOf: url) {
//                                            if let image = UIImage(data: data) {
//                                                self.displayedMoviePosters[movieId] = image
//                                            } else {
//                                                self.displayedMoviePosters[movieId] = UIImage(named: "no_image")
//                                            }
//                                        } else {
//                                            self.displayedMoviePosters[movieId] = UIImage(named: "no_image")
//                                        }
//                                    } else {
//                                        self.displayedMoviePosters[movieId] = UIImage(named: "no_image")
//                                    }
//                                } else {
//                                    self.displayedMoviePosters[movieId] = UIImage(named: "no_image")
//                                }
//                                DispatchQueue.main.async {
//                                    self.tableView.reloadData()
//                                }
//                            }
//                        }
//                    }
//                }
//                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
}
