//
//  GenreProtocols.swift
//  TheMovieDB
//
//  Created by David Silaban on 04/08/23.
//

import Foundation
import UIKit

protocol GenreListPresenterToViewProtocol: AnyObject {
    func showMovieGenres()
    func showMovieGenresError()
}

protocol GenreListInteractorToPresenterProtocol: AnyObject {
    func genresFetched()
    func genresFetchFailed()
}

protocol GenreListPresenterToInteractorProtocol: AnyObject {
    var presenter: GenreListInteractorToPresenterProtocol? { get set }
    var genres: [GenreModel]? { get }
    
    func fetchMovieGenres()
}

protocol GenreListViewToPresenterProtocol: AnyObject {
    var view: GenreListPresenterToViewProtocol? { get set }
    var interactor: GenreListPresenterToInteractorProtocol? { get set }
    var router: GenreListPresenterToRouterProtocol? { get set }
    
    func updateView()
    func getGenreListCount() -> Int?
    func getGenre(index: Int) -> GenreModel?
}

protocol GenreListPresenterToRouterProtocol: AnyObject {
    static func createModule(view: GenresTableViewController)
}
