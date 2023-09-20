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
    @State private var searchQuery: String = ""
    @State private var showingSortOptions: Bool = false
    @State private var selectedSortOption: Int = 0
    @State private var selectedMovie: Movie? = nil

    let sortOptions = ["Popularity", "Title", "Release Date", "Vote Average"]


    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                SearchBar(text: $searchQuery, placeholder: "Search movies")
                    .padding(.top, 10)
                
                List(viewModel.movies.filter { movie in
                    searchQuery.isEmpty || movie.title.lowercased().contains(searchQuery.lowercased())
                }, id: \.id) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MainMovieInfo(movie: movie)
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
            }
            .navigationBarTitle("Popular Movies", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                showingSortOptions.toggle()
            }) {
                Image(systemName: "arrow.up.arrow.down.square")
            })
            .actionSheet(isPresented: $showingSortOptions) {
                ActionSheet(title: Text("Sort By"), buttons: sortOptions.enumerated().map { index, option in
                    .default(Text(option), action: {
                        selectedSortOption = index
                        // Handle the sorting logic using the selected option
                        viewModel.sortMovies(by: index) // You'll need to implement this in the viewModel
                    })
                } + [.cancel()])
            }
        }
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
}



