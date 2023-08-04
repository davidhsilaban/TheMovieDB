//
//  MoviePrimaryInfoInteractor.swift
//  TheMovieDB
//
//  Created by Jawasoft on 04/08/23.
//

import Foundation

class MoviePrimaryInfoInteractor: MoviePrimaryInfoPresenterToInteractorProtocol {

    // MARK: - Properties
    weak var presenter: MoviePrimaryInfoInteractorToPresenterProtocol?
    var movieInfo: MoviePrimaryInfoModel?
    var movieVideos: [MovieVideosResultModel]?
    
    // MARK: - Methods
    func fetchMovieInfo(movieId: Int) {
        TMDBAPIInterface.shared.getPrimaryInfoByMovieId(movieId: movieId) { (success, statusCode, data) in
            if !success || !((200...299).contains(statusCode)) {
                self.presenter?.movieInfoFetchFailed()
                return
            }
            guard let data = data else { return }
            
            TMDBAPIInterface.shared.getVideosByMovieId(movieId: movieId) { (success, statusCode, dataVid) in
                if !success || !((200...299).contains(statusCode)) {
                    self.presenter?.movieInfoFetchFailed()
                    return
                }
                guard let dataVid = dataVid else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let movieVideosResponse = try decoder.decode(MovieVideosResponseModel.self, from: dataVid)
                    guard let movieVideos = movieVideosResponse.results else { return }
                    self.movieVideos = movieVideos
                    
                    let movieInfoResponse = try decoder.decode(MoviePrimaryInfoModel.self, from: data)
//                    guard let movieInfo = movieInfoResponse else { return }
                    self.movieInfo = movieInfoResponse
                    self.presenter?.movieInfoFetched()
                } catch let error {
                    print(error)
                }
            }
        }
    }
}
