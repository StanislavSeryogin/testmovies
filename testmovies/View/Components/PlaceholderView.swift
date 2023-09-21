//
//  PlaceholderView.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        VStack {
            Image(systemName: "film")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .opacity(0.2)
            Text("Awaiting action...")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView()
    }
}
