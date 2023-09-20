//
//  Content_View.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

import SwiftUI

struct MainMoviesContentView: View {
    
    @StateObject var viewModel = MovieListViewModel()
    @State private var isShowingActionSheet = false
    @State private var selectedSortOption: MovieSortOption = .popularity
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.trendingState {
                case .none:
                    PlaceholderView()
                case .loading:
                    ProgressView()
                case .error(let message):
                    Text(message)
                case .trendingItem(let movies), .searchResult(let movies):
                    List(movies) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            MainMovieInfo(movie: movie)
                        }
                    }
                }
            }
            .background(ColorConstants.backgroundColor.ignoresSafeArea())
            .searchable(text: $searchText)
            .onChange(of: searchText) { newValue in
                if newValue.count > 2 {
                    Task {
                        await viewModel.search(term: newValue)
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchMoreMovies()
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Popular Movies").font(.largeTitle.bold())
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingActionSheet = true
                    }) {
                        Image(systemName: "arrow.up.arrow.down")
                            .foregroundColor(.white)
                    }
                }
            }
            .actionSheet(isPresented: $isShowingActionSheet) {
                ActionSheet(title: Text("Select Sorting Option"), buttons: sortingOptions())
            }
        }
    }
    
    func sortingOptions() -> [ActionSheet.Button] {
        var buttons: [ActionSheet.Button] = []
        for option in MovieSortOption.allCases {
            buttons.append(
                .default(Text(option.rawValue + (selectedSortOption == option ? " ✓" : "")), action: {
                    selectedSortOption = option
                    viewModel.sortMovies(by: option)
                })
            )
        }
        buttons.append(.cancel())
        return buttons
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMoviesContentView()
    }
}


