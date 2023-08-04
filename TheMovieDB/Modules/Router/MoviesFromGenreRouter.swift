//
//  MoviesFromGenreRouter.swift
//  TheMovieDB
//
//  Created by David Silaban on 04/08/23.
//

import Foundation
import UIKit

class MoviesFromGenreRouter: MoviesFromGenreListPresenterToRouterProtocol{
    
    // MARK: - Methods
    
    class func createModule(view: MoviesFromGenreTableViewController) {
        let presenter: MoviesFromGenreListViewToPresenterProtocol & MoviesFromGenreListInteractorToPresenterProtocol = MoviesFromGenrePresenter()
        let interactor: MoviesFromGenreListPresenterToInteractorProtocol = MoviesFromGenreInteractor()
        let router: MoviesFromGenreListPresenterToRouterProtocol = MoviesFromGenreRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}
