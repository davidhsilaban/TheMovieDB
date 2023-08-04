//
//  MoviesFromGenrePresenter.swift
//  TheMovieDB
//
//  Created by David Silaban on 04/08/23.
//

import Foundation

class MoviesFromGenrePresenter: MoviesFromGenreListViewToPresenterProtocol {
    
    // MARK: - Properties
    weak var view: MoviesFromGenreListPresenterToViewProtocol?
    var interactor: MoviesFromGenreListPresenterToInteractorProtocol?
    var router: MoviesFromGenreListPresenterToRouterProtocol?
    
    // MARK: - Methods
    func updateView(genreId: Int, page: Int) {
        interactor?.fetchMoviesFromGenreId(genreId: genreId, page: page)
    }
    
    func getMoviesListCount() -> Int? {
        return interactor?.movies?.count
    }
    
    func getMoviesPageTotal() -> Int? {
        return interactor?.pageTotal
    }
    
    func getMovie(index: Int) -> MoviesByGenreResultsModel? {
        return interactor?.movies?[index]
    }
    
    func getMoviesGrandTotal() -> Int? {
        return interactor?.moviesGrandTotal
    }
    
}

// MARK: - MoviesFromGenreListInteractorToPresenterProtocol
extension MoviesFromGenrePresenter: MoviesFromGenreListInteractorToPresenterProtocol {
    
    func moviesFetched() {
        view?.showMoviesFromGenre()
    }
    
    func moviesFetchFailed() {
        view?.showMoviesFromGenreError()
    }
}
