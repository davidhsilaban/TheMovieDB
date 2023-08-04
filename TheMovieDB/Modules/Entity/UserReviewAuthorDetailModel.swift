//
//  UserReviewAuthorDetailModel.swift
//  TheMovieDB
//
//  Created by David Silaban on 04/08/23.
//

import Foundation

struct UserReviewAuthorDetailModel : Codable {
    let name : String?
    let username : String?
    let avatar_path : String?
    let rating : Int?
}
