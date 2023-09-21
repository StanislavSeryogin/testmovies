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
                
            VStack(alignment: .leading) {
                Spacer()
                VStack {
                    HStack {
                        Text(movie.title)
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .lineLimit(1)
                        Spacer()
                        Text(movie.genreText)
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .lineLimit(1)
                    }
                    HStack {
                        Image(systemName: "hand.thumbsup.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", movie.vote_average))
                            .fontWeight(.heavy)
                            .foregroundColor(.yellow)
                        Spacer()
                        Text(movie.releaseYear ?? "")
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                    }
                }
                .padding()
                .background(ColorConstants.backgroundImageColor)
            }
        }
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
    }
}
