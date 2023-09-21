//
//  TitleAndGenre.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 21.09.2023.
//

import SwiftUI

struct TitleAndGenreText: View {
    let title: String
    let genre: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .lineLimit(1)
            Spacer()
            Text(genre)
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .lineLimit(1)
        }
    }
}
