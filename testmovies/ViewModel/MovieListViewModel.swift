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
    @Published var trendingState: TrendingState = .none

    private var movieService: MovieService

    init(movieService: MovieService = AFMovieService()) {
        self.movieService = movieService
    }

    func search(term: String) async {
        // Prevent searching for empty strings
        guard !term.trimmingCharacters(in: .whitespaces).isEmpty else {
            trendingState = .none
            return
        }

        trendingState = .loading

        do {
            let searchResults = try await movieService.searchMovies(term: term, page: 1)
            if searchResults.isEmpty {
                trendingState = .none
            } else {
                trendingState = .searchResult(searchResults)
                currentPage = 1
            }
        } catch {
            trendingState = .error(message: "Failed to search movies")
        }
    }
    
    func fetchMoreMovies() async {
        trendingState = .loading

        do {
            let newMovies = try await movieService.fetchPopularMovies(page: currentPage)
            if newMovies.isEmpty {
                trendingState = .none
            } else {
                trendingState = .trendingItem(newMovies)
                currentPage += 1
            }
        } catch {
            trendingState = .error(message: "Failed to fetch movies")
        }
    }

    func sortMovies(by option: MovieSortOption) {
        movies.sort(by: option.sortDescriptor())
    }
}

