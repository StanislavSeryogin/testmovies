//
//  Content_View.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MovieListViewModel()
    
    var body: some View {
        List(viewModel.movies, id: \.id) { movie in
            MainMovieInfo(movie: movie)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
