//
//  Interface.swift
//  TheMovieDB
//
//  Created by David Silaban on 23/08/21.
//

import Foundation

class TMDBAPIInterface {
    static let shared = TMDBAPIInterface()
    
    private let apiHttpRequest = APIHTTPRequest()
    
    func getMovieGenres(completionHandler: @escaping (Bool, Int, [String:Any]?) -> Void) {
        apiHttpRequest.httpGet(endpoint: "/genre/movie/list", params: nil, completionHandler: completionHandler)
    }
    
    func getDiscoverMovies(genreId: Int, page: Int, completionHandler: @escaping (Bool, Int, [String:Any]?) -> Void) {
        apiHttpRequest.httpGet(endpoint: "/discover/movie", params: ["with_genres": genreId, "page": page, "include_video": true, "sort_by": "original_title.asc"], completionHandler: completionHandler)
    }
    
    func getPrimaryInfoByMovieId(movieId: Int, completionHandler: @escaping (Bool, Int, [String:Any]?) -> Void) {
        apiHttpRequest.httpGet(endpoint: "/movie/\(movieId)", params: nil, completionHandler: completionHandler)
    }
    
    func getVideosByMovieId(movieId: Int, completionHandler: @escaping (Bool, Int, [String:Any]?) -> Void) {
        apiHttpRequest.httpGet(endpoint: "/movie/\(movieId)/videos", params: nil, completionHandler: completionHandler)
    }
    
    func getReviewsByMovieId(movieId: Int, page: Int, completionHandler: @escaping (Bool, Int, [String:Any]?) -> Void) {
        apiHttpRequest.httpGet(endpoint: "/movie/\(movieId)/reviews", params: ["page": page], completionHandler: completionHandler)
    }
}
