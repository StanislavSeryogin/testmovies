//
//  TrendingState.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

enum TrendingState {
    case none
    case loading
    case error(message: String)
    case trendingItem([Movie])
    case searchResult([Movie])
}
