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
    let trailer_path: String?
    let country: String?
    let popularity: Float?
    
   static let baseImageURL = APIConstants.baseImageURL
   static let genreMapping = GenreList.genreMapping
    
    var hasTrailer: Bool {
           return trailer_path != nil
       }

       var trailerURL: URL? {
           guard let trailerPath = trailer_path else { return nil }
           return URL(string: "\(Movie.baseImageURL)\(trailerPath)")
       }

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
    
    var description: String {
        return overview
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
        self.trailer_path = entity.trailer_path
        self.country = entity.country
        self.popularity = entity.popularity
        if let genreIDsSet = entity.genre_ids as? NSOrderedSet {
            self.genre_ids = genreIDsSet.array as? [Int]
        } else {
            self.genre_ids = nil
        }
    }
}

