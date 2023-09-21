//
//  RatingsAndYear.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 21.09.2023.
//

import SwiftUI

struct RatingsAndYearText: View {
    let rating: Float
    let year: String?
    
    var body: some View {
        HStack {
            Image(systemName: "hand.thumbsup.fill")
                .foregroundColor(.yellow)
            Text(String(format: "%.1f", rating))
                .fontWeight(.heavy)
                .foregroundColor(.yellow)
            Spacer()
            Text(year ?? "")
                .foregroundColor(.white)
                .fontWeight(.medium)
        }
    }
}
