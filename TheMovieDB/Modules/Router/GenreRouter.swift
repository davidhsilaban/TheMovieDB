//
//  GenreRouter.swift
//  TheMovieDB
//
//  Created by David Silaban on 04/08/23.
//

import Foundation
import UIKit

class GenreRouter: GenreListPresenterToRouterProtocol{
    
    // MARK: - Methods
    
    class func createModule(view: GenresTableViewController) {
        let presenter: GenreListViewToPresenterProtocol & GenreListInteractorToPresenterProtocol = GenrePresenter()
        let interactor: GenreListPresenterToInteractorProtocol = GenreInteractor()
        let router: GenreListPresenterToRouterProtocol = GenreRouter()
        
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
