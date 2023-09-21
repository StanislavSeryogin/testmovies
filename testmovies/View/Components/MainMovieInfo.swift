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
        ZStack(alignment: .bottom) {
            KFImage(movie.posterURL)
                .resizable()
                .scaledToFill()
                .clipped()
            MovieInfoText(movie: movie)
        }
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
    }
}

struct MovieInfoText: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            VStack {
                TitleAndGenreText(title: movie.title, genre: movie.genreText)
                RatingsAndYearText(rating: movie.vote_average, year: movie.releaseYear)
            }
            .padding()
            .background(ColorConstants.backgroundImageColor)
        }
    }
}
