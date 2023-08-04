//
//  MoviePrimaryInfoPresenter.swift
//  TheMovieDB
//
//  Created by David Silaban on 04/08/23.
//

import Foundation

class MoviePrimaryInfoPresenter: MoviePrimaryInfoViewToPresenterProtocol {
    
    // MARK: - Properties
    weak var view: MoviePrimaryInfoPresenterToViewProtocol?
    var interactor: MoviePrimaryInfoPresenterToInteractorProtocol?
    var router: MoviePrimaryInfoPresenterToRouterProtocol?
    
    // MARK: - Methods
    func updateView(movieId: Int) {
        interactor?.fetchMovieInfo(movieId: movieId)
    }
    
    func getMovieSpokenLanguagesListCount() -> Int? {
        return interactor?.movieInfo?.spoken_languages?.count
    }
    
    func getMovieProductionCompaniesListCount() -> Int? {
        return interactor?.movieInfo?.production_companies?.count
    }
    
    func getMovieProductionCountriesListCount() -> Int? {
        return interactor?.movieInfo?.production_countries?.count
    }
    
    func getMovieInfo() -> MoviePrimaryInfoModel? {
        return interactor?.movieInfo
    }
    
    func getMovieVideosListCount() -> Int? {
        return interactor?.movieVideos?.count
    }
    
    func getMovieVideos() -> [MovieVideosResultModel]? {
        return interactor?.movieVideos
    }
}

// MARK: - MoviePrimaryInfoInteractorToPresenterProtocol
extension MoviePrimaryInfoPresenter: MoviePrimaryInfoInteractorToPresenterProtocol {
    func movieInfoFetched() {
        view?.showMovieInfo()
    }
    
    func movieInfoFetchFailed() {
        view?.showMovieInfoError()
    }
}
