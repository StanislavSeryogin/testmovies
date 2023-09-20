//
//  SortingOption.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

enum MovieSortOption: String, CaseIterable {
    case popularity = "Popularity"
    case title = "Title"
    case releaseDate = "Release Date"
    case voteAverage = "Vote Average"
    
    func sortDescriptor() -> (Movie, Movie) -> Bool {
        switch self {
        case .popularity:
            // Here you would need to define a 'popularity' property in your Movie struct.
            return { $0.popularity ?? 0.0 > $1.popularity ?? 0.0 }
        case .title:
            return { $0.title < $1.title }
        case .releaseDate:
            return { $0.release_date ?? "" > $1.release_date ?? "" }
        case .voteAverage:
            return { $0.vote_average > $1.vote_average }
        }
    }
}

