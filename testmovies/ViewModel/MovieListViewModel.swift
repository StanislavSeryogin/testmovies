//
//  MovieListViewModel.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

import Foundation

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var currentPage: Int = 1
    @Published var canLoadMore: Bool = true

    private var movieService: MovieService

    init(movieService: MovieService = AFMovieService()) {
        self.movieService = movieService
    }

    func fetchMoreMovies() async {
        guard !isLoading && canLoadMore else { return }

        isLoading = true
        do {
            let newMovies = try await movieService.fetchPopularMovies(page: currentPage)
            if newMovies.isEmpty {
                canLoadMore = false
            }
            movies.append(contentsOf: newMovies)
            currentPage += 1
        } catch {
            print(error)
        }
        isLoading = false
    }
    
    func sortMovies(by option: Int) {
        switch option {
        case 0: // Popularity
            movies.sort(by: { $0.popularity ?? 0.0 > $1.popularity ?? 0.0 })
        case 1: // Title
            movies.sort(by: { $0.title < $1.title })
        case 2: // Release Date
            movies.sort(by: { $0.release_date ?? "" > $1.release_date ?? "" })
        case 3: // Vote Average
            movies.sort(by: { $0.vote_average > $1.vote_average })
        default:
            break // Do nothing for default
        }
    }

}
