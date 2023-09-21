//
//  MovieDetailView.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    @Environment(\.dismiss) var dismiss
    let movie: Movie
    @State private var showTrailer: Bool = false
    @State private var showFullScreenPoster: Bool = false
    
    var body: some View {
        ZStack {
            ColorConstants.backgroundColor.ignoresSafeArea()
            VStack(alignment: .center) {
                KFImage(movie.posterURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
                    .onTapGesture {
                        showFullScreenPoster = true
                    }
                    .fullScreenCover(isPresented: $showFullScreenPoster, content: {
                        FullSizePosterView(posterURL: movie.posterURL!) {
                            showFullScreenPoster = false
                        }
                    })
                VStack (alignment: .leading) {
                    TitleAndGenreText(title: movie.title, genre: movie.genreText)
                    RatingsAndYearText(rating: movie.vote_average, year: movie.releaseYear)
                    
                    Divider()
                        .background(Color.white)
                        .padding(.vertical)
                    Text("\(movie.country ?? "")")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                    
                    Text(movie.overview)
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                    
                    // Trailer button
                    if movie.hasTrailer {
                        Button("Trailer") {
                            showTrailer = true
                        }
                        .sheet(isPresented: $showTrailer) {
                            AVPlayerViewControllerRepresentable(avURL: movie.trailerURL!)
                        }
                    }
                    Spacer()
                }
                
            }
            .padding()
            //            .navigationTitle(movie.title)
            //            .navigationBarTitleDisplayMode(.inline)
            //            .toolbar {
            //                ToolbarItem(placement: .principal) {
            //                    Text(movie.title)
            //                        .font(.largeTitle)
            //                        .foregroundColor(.white)
            //                }
            //            }
        }
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
            .padding(.leading, 16)
            .padding(.top, 16)
        }
        .navigationBarHidden(true)
    }
}
