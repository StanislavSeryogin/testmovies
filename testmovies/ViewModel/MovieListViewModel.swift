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
}
