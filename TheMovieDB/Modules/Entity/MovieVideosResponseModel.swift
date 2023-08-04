//
//  MovieVideosResponseModel.swift
//  TheMovieDB
//
//  Created by David Silaban on 04/08/23.
//

import Foundation
struct MovieVideosResponseModel : Codable {
    let id : Int?
    let results : [MovieVideosResultModel]?
}
