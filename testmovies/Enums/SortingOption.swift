//
//  SortingOption.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

enum SortingOption: String, CaseIterable {
    case popularityDesc = "Popularity (Descending)"
    case popularityAsc = "Popularity (Ascending)"
    case releaseDateDesc = "Release Date (Descending)"
    case releaseDateAsc = "Release Date (Ascending)"
    case titleAsc = "Title (Alphabetical)"
    case titleDesc = "Title (Reverse Alphabetical)"
    case voteAverageDesc = "Vote Average (Descending)"
    case voteAverageAsc = "Vote Average (Ascending)"
    
    var apiParameter: String {
        switch self {
        case .popularityDesc:
            return "popularity.desc"
        case .popularityAsc:
            return "popularity.asc"
        case .releaseDateDesc:
            return "release_date.desc"
        case .releaseDateAsc:
            return "release_date.asc"
        case .titleAsc:
            return "original_title.asc"
        case .titleDesc:
            return "original_title.desc"
        case .voteAverageDesc:
            return "vote_average.desc"
        case .voteAverageAsc:
            return "vote_average.asc"
        }
    }
}

