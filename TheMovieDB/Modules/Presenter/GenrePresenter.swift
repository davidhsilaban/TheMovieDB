//
//  GenrePresenter.swift
//  TheMovieDB
//
//  Created by David Silaban on 04/08/23.
//

import Foundation

class GenrePresenter: GenreListViewToPresenterProtocol {
    
    // MARK: - Properties
    weak var view: GenreListPresenterToViewProtocol?
    var interactor: GenreListPresenterToInteractorProtocol?
    var router: GenreListPresenterToRouterProtocol?
    
    // MARK: - Methods
    func updateView() {
        interactor?.fetchMovieGenres()
    }
    
    func getGenreListCount() -> Int? {
        return interactor?.genres?.count
    }
    
    func getGenre(index: Int) -> GenreModel? {
        return interactor?.genres?[index]
    }
}

// MARK: - GenreListInteractorToPresenterProtocol
extension GenrePresenter: GenreListInteractorToPresenterProtocol {
    
    func genresFetched() {
        view?.showMovieGenres()
    }
    
    func genresFetchFailed() {
        view?.showMovieGenresError()
    }
}
