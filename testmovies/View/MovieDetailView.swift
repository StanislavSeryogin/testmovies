//
//  MovieDetailView.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

import SwiftUI
import Kingfisher
import AVKit

struct MovieDetailView: View {
    let movie: Movie
    @State private var showTrailer: Bool = false
    @State private var showFullScreenPoster: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            // Poster
            KFImage(movie.posterURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 300)
                .onTapGesture {
                    showFullScreenPoster = true
                }
                .fullScreenCover(isPresented: $showFullScreenPoster, content: {
                    FullSizePosterView(posterURL: movie.posterURL!) {
                        showFullScreenPoster = false
                    }
                })

            
            // Other Movie Details...
            Text(movie.title)
            Text("\(movie.releaseYear ?? "") \(movie.country ?? "")")
            Text(movie.genreText)
            Text(movie.overview)
            Text("Rating: \(movie.vote_average)")
            
            // Trailer Button
            if movie.hasTrailer { // A condition to check if trailer URL is available
                Button("Trailer") {
                    showTrailer = true
                }
                .sheet(isPresented: $showTrailer) {
                    AVPlayerViewControllerRepresentable(avURL: movie.trailerURL!)
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AVPlayerViewControllerRepresentable: UIViewControllerRepresentable {
    let avURL: URL
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        let player = AVPlayer(url: avURL)
        controller.player = player
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Nothing here for now
    }
}

struct FullSizePosterView: View {
    let posterURL: URL
    let closeAction: () -> Void
    
    var body: some View {
        VStack {
            ScrollView([.horizontal, .vertical], showsIndicators: false) {
                KFImage(posterURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .gesture(MagnificationGesture().onChanged { scale in
                        // Handle zoom gesture
                    })
            }
            Button(NSLocalizedString("Close", comment: "Close button")) {
                closeAction()
            }
            .padding(.top, 10)
        }
    }
}


