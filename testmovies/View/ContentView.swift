//
//  Content_View.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MovieListViewModel()
    @State private var showingAlert: Bool = false

    var body: some View {
        NavigationView {
            List(viewModel.movies, id: \.id) { movie in
                if NetworkUtils.hasInternetConnection() {
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MainMovieInfo(movie: movie)
                    }
                } else {
                    MainMovieInfo(movie: movie)
                        .onTapGesture {
                            showingAlert = true
                        }
                }
            }
            .task {
                await viewModel.fetchMoreMovies()
            }
            .onAppear {
                if viewModel.movies.isEmpty {
                    Task {
                        await viewModel.fetchMoreMovies()
                    }
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Network Error"),
                      message: Text("You are offline. Please, enable your Wi-Fi or connect using cellular data."),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


