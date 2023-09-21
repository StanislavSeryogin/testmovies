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
    @Published var selectedLanguage: String = "en"
    @Published var currentSortingOption: MovieSortOption = .popularity
    
    private var movieService: MovieService
    
    init(movieService: MovieService = AFMovieService()) {
        self.movieService = movieService
    }
    
    func toggleLanguage() {
        if selectedLanguage == "en" {
            selectedLanguage = "uk"
            Bundle.setLanguage("uk")
        } else {
            selectedLanguage = "en"
            Bundle.setLanguage("en")
        }
    }
    
    var currentLanguage: String {
        return selectedLanguage
    }
    
    func search(term: String) async {
        guard !term.trimmingCharacters(in: .whitespaces).isEmpty else {
            trendingState = .none
            movies = []
            return
        }
        trendingState = .loading
        do {
            let searchResults = try await movieService.searchMovies(term: term, page: 1)
            if searchResults.isEmpty {
                trendingState = .none
                movies = []
            } else {
                trendingState = .searchResult(searchResults)
                movies = searchResults
                currentPage = 1
            }
        } catch {
            trendingState = .error(message: "Failed to search movies")
        }
    }
    
    func fetchMoreMovies() async {
        guard canLoadMore else {
            trendingState = .none
            return
        }
        trendingState = .loading
        do {
            let newMovies = try await movieService.fetchPopularMovies(page: currentPage)
            if newMovies.isEmpty {
                trendingState = .none
                canLoadMore = false
            } else {
                trendingState = .trendingItem(newMovies)
                movies.append(contentsOf: newMovies)
                currentPage += 1
            }
        } catch {
            trendingState = .error(message: "Failed to fetch movies")
        }
    }
    
    func sortMovies(by option: MovieSortOption) {
        let comparator = option.sortDescriptor()
        movies.sort(by: comparator)
        currentSortingOption = option
        switch trendingState {
        case .trendingItem:
            trendingState = .trendingItem(movies)
        case .searchResult:
            trendingState = .searchResult(movies)
        default:
            break
        }
    }
    
    var toolBarTitle: String {
          switch currentSortingOption {
          case .popularity:
              return NSLocalizedString("Popular Movies", comment: "Title for the movie list")
          case .title:
              return NSLocalizedString("Title", comment: "Sorted by title")
          case .releaseDate:
              return NSLocalizedString("Release Date", comment: "Sorted by release date")
          case .voteAverage:
              return NSLocalizedString("Vote Average", comment: "Sorted by vote average")
          }
      }
}

