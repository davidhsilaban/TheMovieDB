//
//  UserReviewModel.swift
//  TheMovieDB
//
//  Created by David Silaban on 04/08/23.
//

import Foundation

struct UserReviewResponseModel : Codable {
    let id : Int?
    let page : Int?
    let results : [UserReviewResultsModel]?
    let total_pages : Int?
    let total_results : Int?
}
