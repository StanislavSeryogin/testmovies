//
//  testmoviesApp.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

import SwiftUI

@main
struct testmoviesApp: App {
    var body: some Scene {
        WindowGroup {
            MainMoviesContentView()
                .preferredColorScheme(.dark)
        }
    }
}
