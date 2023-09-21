//
//  FullSizePosterView.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 21.09.2023.
//

import SwiftUI
import Kingfisher

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
