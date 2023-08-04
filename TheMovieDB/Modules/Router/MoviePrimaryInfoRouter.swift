//
//  MoviePrimaryInfoRouter.swift
//  TheMovieDB
//
//  Created by David Silaban on 04/08/23.
//

import Foundation
import UIKit

class MoviePrimaryInfoRouter: MoviePrimaryInfoPresenterToRouterProtocol{
    
    // MARK: - Methods
    
    class func createModule(view: MoviePrimaryInfoViewController) {
        let presenter: MoviePrimaryInfoViewToPresenterProtocol & MoviePrimaryInfoInteractorToPresenterProtocol = MoviePrimaryInfoPresenter()
        let interactor: MoviePrimaryInfoPresenterToInteractorProtocol = MoviePrimaryInfoInteractor()
        let router: MoviePrimaryInfoPresenterToRouterProtocol = MoviePrimaryInfoRouter()
        
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
