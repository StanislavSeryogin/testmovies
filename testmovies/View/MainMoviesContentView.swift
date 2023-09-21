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
                    TrendingMoviesView(movies: movies)
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
                    Text(viewModel.toolBarTitle)
                        .font(.largeTitle.bold())
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
                   SortingActionSheet(selectedSortOption: $selectedSortOption) { option in
                       viewModel.sortMovies(by: option)
                   }.actionSheet()
               }
            .overlay(
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            Task {
                                viewModel.toggleLanguage()
                            }
                        }) {
                            Text(viewModel.selectedLanguage == "en" ? "🇬🇧" : "🇺🇦")
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        
                    }
                }
                    .padding(), alignment: .bottomLeading
            )
        }
        
    }
}

struct MainMoviesContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMoviesContentView()
    }
}
