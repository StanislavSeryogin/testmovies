//
//  TrendingMoviesView.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 21.09.2023.
//

import SwiftUI

struct TrendingMoviesView: View {
    let movies: [Movie]
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(movies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MainMovieInfo(movie: movie)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
