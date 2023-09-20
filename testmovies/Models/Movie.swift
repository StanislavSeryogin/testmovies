//
//  Movie.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

import Foundation

struct Movie: Decodable, Identifiable, Equatable {
    let id: Int
    let title: String
    let overview: String
    let vote_average: Float
    let release_date: String?
    let poster_path: String?
    let genre_ids: [Int]?

    static let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
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

    var genreText: String {
        guard let genreIds = genre_ids else {
            return "Unknown Genre"
        }
        return genreIds.compactMap { Movie.genreMapping[$0] }.joined(separator: ", ")
    }

    var releaseYear: String? {
        guard let date = release_date, let year = date.split(separator: "-").first else {
            return "Unknown Year"
        }
        return String(year)
    }

    var posterURL: URL? {
        guard let posterPath = poster_path else { return nil }
        return URL(string: "\(Movie.baseImageURL)\(posterPath)")
    }

    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Movie {
    init(entity: MovieEntity) {
        self.id = Int(entity.id)
        self.title = entity.title ?? ""
        self.overview = entity.overview ?? ""
        self.vote_average = entity.vote_average
        self.release_date = entity.release_date
        self.poster_path = entity.poster_path
        if let genreIDsSet = entity.genre_ids as? NSOrderedSet {
            self.genre_ids = genreIDsSet.array as? [Int]
        } else {
            self.genre_ids = nil
        }
    }
}
