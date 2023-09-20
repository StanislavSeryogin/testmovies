//
//  MovieListView.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()

    var body: some View {
        List(viewModel.movies, id: \.id) { movie in
            MovieRow(movie: movie)
        }
        .task { // Use the .task modifier for async work
            await viewModel.fetchMoreMovies()
        }
        .onAppear {
            if viewModel.movies.isEmpty {
                Task {
                    await viewModel.fetchMoreMovies()
                }
            }
        }
    }
}


struct MovieRow: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: movie.posterURL) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            Text(movie.title)
            Text(movie.genreText)
            Text("\(movie.vote_average)")
            Text(movie.releaseYear ?? "")
        }
    }
}


extension Array where Element: Equatable {
    func isLast(_ element: Element) -> Bool {
        guard let lastElement = last else {
            return false
        }
        return element == lastElement
    }
}
