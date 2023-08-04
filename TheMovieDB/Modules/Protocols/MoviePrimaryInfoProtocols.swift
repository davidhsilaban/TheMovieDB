//
//  MoviePrimaryInfoProtocols.swift
//  TheMovieDB
//
//  Created by David Silaban on 04/08/23.
//

import Foundation
import UIKit

protocol MoviePrimaryInfoPresenterToViewProtocol: AnyObject {
    func showMovieInfo()
    func showMovieInfoError()
}

protocol MoviePrimaryInfoInteractorToPresenterProtocol: AnyObject {
    func movieInfoFetched()
    func movieInfoFetchFailed()
}

protocol MoviePrimaryInfoPresenterToInteractorProtocol: AnyObject {
    var presenter: MoviePrimaryInfoInteractorToPresenterProtocol? { get set }
    var movieInfo: MoviePrimaryInfoModel? { get }
    var movieVideos: [MovieVideosResultModel]? { get }
    
    func fetchMovieInfo(movieId: Int)
}

protocol MoviePrimaryInfoViewToPresenterProtocol: AnyObject {
    var view: MoviePrimaryInfoPresenterToViewProtocol? { get set }
    var interactor: MoviePrimaryInfoPresenterToInteractorProtocol? { get set }
    var router: MoviePrimaryInfoPresenterToRouterProtocol? { get set }
    
    func updateView(movieId: Int)
    func getMovieProductionCompaniesListCount() -> Int?
    func getMovieProductionCountriesListCount() -> Int?
    func getMovieSpokenLanguagesListCount() -> Int?
    func getMovieVideosListCount() -> Int?
    func getMovieInfo() -> MoviePrimaryInfoModel?
    func getMovieVideos() -> [MovieVideosResultModel]?
}

protocol MoviePrimaryInfoPresenterToRouterProtocol: AnyObject {
    static func createModule(view: MoviePrimaryInfoViewController)
}

