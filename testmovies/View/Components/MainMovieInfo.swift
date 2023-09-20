//
//  MainMovieInfo.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

import SwiftUI

struct MainMovieInfo: View {
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
