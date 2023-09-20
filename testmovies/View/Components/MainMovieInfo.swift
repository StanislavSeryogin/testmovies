//
//  MainMovieInfo.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

import SwiftUI
import Kingfisher

struct MainMovieInfo: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            KFImage(movie.posterURL)
                .resizable()
                .scaledToFit()
            Text(movie.title)
            Text(movie.genreText)
            Text("\(movie.vote_average)")
            Text(movie.releaseYear ?? "")
        }
    }
}
