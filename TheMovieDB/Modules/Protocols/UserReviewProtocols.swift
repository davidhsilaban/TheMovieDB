//
//  UserReviewProtocols.swift
//  TheMovieDB
//
//  Created by David Silaban on 04/08/23.
//

import Foundation
import UIKit

protocol UserReviewListPresenterToViewProtocol: AnyObject {
    func showUserReviews()
    func showUserReviewsError()
}

protocol UserReviewListInteractorToPresenterProtocol: AnyObject {
    func userReviewsFetched()
    func userReviewsFetchFailed()
}

protocol UserReviewListPresenterToInteractorProtocol: AnyObject {
    var presenter: UserReviewListInteractorToPresenterProtocol? { get set }
    var userReviews: [UserReviewResultsModel]? { get }
    var page: Int? { get }
    var pageTotal: Int? { get }
    var reviewsTotal: Int? { get }
    
    func fetchUserReviews(movieId: Int, page: Int)
}

protocol UserReviewListViewToPresenterProtocol: AnyObject {
    var view: UserReviewListPresenterToViewProtocol? { get set }
    var interactor: UserReviewListPresenterToInteractorProtocol? { get set }
    var router: UserReviewListPresenterToRouterProtocol? { get set }
    
    func updateView(movieId: Int, page: Int)
    func getUserReviewsListCount() -> Int?
    func getUserReview(index: Int) -> UserReviewResultsModel?
    func getUserReviewsPageTotal() -> Int?
    func getUserReviewsTotal() -> Int?
}

protocol UserReviewListPresenterToRouterProtocol: AnyObject {
    static func createModule(view: UserReviewTableViewController)
}

