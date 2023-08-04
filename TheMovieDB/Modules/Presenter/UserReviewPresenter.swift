//
//  UserReviewPresenter.swift
//  TheMovieDB
//
//  Created by Jawasoft on 04/08/23.
//

import Foundation

import Foundation

class UserReviewPresenter: UserReviewListViewToPresenterProtocol {
    
    // MARK: - Properties
    weak var view: UserReviewListPresenterToViewProtocol?
    var interactor: UserReviewListPresenterToInteractorProtocol?
    var router: UserReviewListPresenterToRouterProtocol?
    
    // MARK: - Methods
    func updateView(movieId: Int, page: Int) {
        interactor?.fetchUserReviews(movieId: movieId, page: page)
    }
    
    func getUserReviewsListCount() -> Int? {
        return interactor?.userReviews?.count
    }
    
    func getUserReview(index: Int) -> UserReviewResultsModel? {
        return interactor?.userReviews?[index]
    }
    
    func getUserReviewsTotal() -> Int? {
        return interactor?.reviewsTotal
    }
    
    func getUserReviewsPageTotal() -> Int? {
        return interactor?.pageTotal
    }
}

// MARK: - UserReviewListInteractorToPresenterProtocol
extension UserReviewPresenter: UserReviewListInteractorToPresenterProtocol {
    
    func userReviewsFetched() {
        view?.showUserReviews()
    }
    
    func userReviewsFetchFailed() {
        view?.showUserReviewsError()
    }
}
