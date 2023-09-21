//
//  Constants.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

import SwiftUI


struct APIConstants {
    static let baseURL = "https://api.themoviedb.org/3"
    static let apiKey = "Api_Key"
    static let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    static func popularMoviesURL(page: Int) -> String {
        return "\(baseURL)/movie/popular?api_key=\(apiKey)&page=\(page)"
    }
    
    static func searchMoviesURL(term: String, page: Int) -> String {
        return "\(baseURL)/search/movie?api_key=\(apiKey)&query=\(term)&page=\(page)"
    }
}


struct ColorConstants {
    static let backgroundColor = Color(red: 39/255, green: 40/255, blue: 59/255)
    static let backgroundImageColor = Color(red: 61/255, green: 61/255, blue: 88/255)
}

struct GenreList {
    static let genreMapping: [Int: String] = [
        28: "Action",
        12: "Adventure",
        16: "Animation",
        35: "Comedy",
        80: "Crime",
        99: "Documentary",
        18: "Drama",
        10751: "Family",
        14: "Fantasy",
        36: "History",
        27: "Horror",
        10402: "Music",
        9648: "Mystery",
        10749: "Romance",
        878: "Science Fiction",
        10770: "TV Movie",
        53: "Thriller",
        10752: "War",
        37: "Western"
    ]
}
