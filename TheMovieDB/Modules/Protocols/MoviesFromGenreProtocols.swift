//
//  MoviesFromGenreProtocols.swift
//  TheMovieDB
//
//  Created by David Silaban on 04/08/23.
//

import Foundation
import UIKit

protocol MoviesFromGenreListPresenterToViewProtocol: AnyObject {
    func showMoviesFromGenre()
    func showMoviesFromGenreError()
}

protocol MoviesFromGenreListInteractorToPresenterProtocol: AnyObject {
    func moviesFetched()
    func moviesFetchFailed()
}

protocol MoviesFromGenreListPresenterToInteractorProtocol: AnyObject {
    var presenter: MoviesFromGenreListInteractorToPresenterProtocol? { get set }
    var movies: [MoviesByGenreResultsModel]? { get }
    var page: Int? { get }
    var pageTotal: Int? { get }
    var moviesGrandTotal: Int? { get }
    
    func fetchMoviesFromGenreId(genreId: Int, page: Int)
}

protocol MoviesFromGenreListViewToPresenterProtocol: AnyObject {
    var view: MoviesFromGenreListPresenterToViewProtocol? { get set }
    var interactor: MoviesFromGenreListPresenterToInteractorProtocol? { get set }
    var router: MoviesFromGenreListPresenterToRouterProtocol? { get set }
    
    func updateView(genreId: Int, page: Int)
    func getMoviesListCount() -> Int?
    func getMoviesPageTotal() -> Int?
    func getMoviesGrandTotal() -> Int?
    func getMovie(index: Int) -> MoviesByGenreResultsModel?
}

protocol MoviesFromGenreListPresenterToRouterProtocol: AnyObject {
    static func createModule(view: MoviesFromGenreTableViewController)
}
