//
//  UserReviewRouter.swift
//  TheMovieDB
//
//  Created by David Silaban on 04/08/23.
//

import Foundation
import UIKit

class UserReviewRouter: UserReviewListPresenterToRouterProtocol{
    
    // MARK: - Methods
    
    class func createModule(view: UserReviewTableViewController) {
        let presenter: UserReviewListViewToPresenterProtocol & UserReviewListInteractorToPresenterProtocol = UserReviewPresenter()
        let interactor: UserReviewListPresenterToInteractorProtocol = UserReviewInteractor()
        let router: UserReviewListPresenterToRouterProtocol = UserReviewRouter()
        
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
