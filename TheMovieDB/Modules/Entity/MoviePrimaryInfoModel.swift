//
//  MoviePrimaryInfo.swift
//  TheMovieDB
//
//  Created by David Silaban on 04/08/23.
//

import Foundation

struct MoviePrimaryInfoModel : Codable {
    let adult : Bool?
    let backdrop_path : String?
//    let belongs_to_collection : [String:AnyObject]?
    let budget : Int?
    let genres : [GenreModel]?
    let homepage : String?
    let id : Int?
    let imdb_id : String?
    let original_language : String?
    let original_title : String?
    let overview : String?
    let popularity : Double?
    let poster_path : String?
    let production_companies : [MovieProductionCompaniesModel]?
    let production_countries : [MovieProductionCountriesModel]?
    let release_date : String?
    let revenue : Int?
    let runtime : Int?
    let spoken_languages : [MovieSpokenLanguagesModel]?
    let status : String?
    let tagline : String?
    let title : String?
    let video : Bool?
    let vote_average : Double?
    let vote_count : Int?
}
