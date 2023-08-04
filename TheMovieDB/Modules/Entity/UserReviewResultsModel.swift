//
//  UserReviewResultsModel.swift
//  TheMovieDB
//
//  Created by David Silaban on 04/08/23.
//

import Foundation

struct UserReviewResultsModel : Codable {
    let author : String?
    let author_details : UserReviewAuthorDetailModel?
    let content : String?
    let created_at : String?
    let id : String?
    let updated_at : String?
    let url : String?
}
