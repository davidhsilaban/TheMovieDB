//
//  GenreInteractor.swift
//  TheMovieDB
//
//  Created by David Silaban on 04/08/23.
//

import Foundation

class GenreInteractor: GenreListPresenterToInteractorProtocol {

    // MARK: - Properties
    weak var presenter: GenreListInteractorToPresenterProtocol?
    var genres: [GenreModel]?
    
    // MARK: - Methods
    func fetchMovieGenres() {
        TMDBAPIInterface.shared.getMovieGenres { (success, statusCode, data) in
            DispatchQueue.main.async {
                if !success || !((200...299).contains(statusCode)) {
                    self.presenter?.genresFetchFailed()
                    return
                }
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let genreResponse = try decoder.decode(GenreResponseModel.self, from: data)
                    guard let genres = genreResponse.genres else { return }
                    self.genres = genres
                    self.presenter?.genresFetched()
                } catch let error {
                    print(error)
                }
            }
        }
    }
}
