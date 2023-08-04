//
//  UserReviewInteractor.swift
//  TheMovieDB
//
//  Created by Jawasoft on 04/08/23.
//

import Foundation

class UserReviewInteractor: UserReviewListPresenterToInteractorProtocol {

    // MARK: - Properties
    weak var presenter: UserReviewListInteractorToPresenterProtocol?
    var userReviews: [UserReviewResultsModel]?
    var page: Int?
    var pageTotal: Int?
    var reviewsTotal: Int?
    
    // MARK: - Methods
    func fetchUserReviews(movieId: Int, page: Int) {
        TMDBAPIInterface.shared.getReviewsByMovieId(movieId: movieId, page: page) { (success, statusCode, data) in
            DispatchQueue.main.async {
                if !success || !((200...299).contains(statusCode)) {
                    self.presenter?.userReviewsFetchFailed()
                    return
                }
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let userReviewResponse = try decoder.decode(UserReviewResponseModel.self, from: data)
                    guard let userReviews = userReviewResponse.results else { return }
                    self.userReviews = userReviews
                    self.reviewsTotal = userReviewResponse.total_results
                    self.presenter?.userReviewsFetched()
                } catch let error {
                    print(error)
                }
            }
        }
    }
}
