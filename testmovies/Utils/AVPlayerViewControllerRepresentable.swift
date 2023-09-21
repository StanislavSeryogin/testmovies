//
//  AVPlayerViewControllerRepresentable.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 21.09.2023.
//

import SwiftUI
import AVKit

struct AVPlayerViewControllerRepresentable: UIViewControllerRepresentable {
    let avURL: URL
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        let player = AVPlayer(url: avURL)
        controller.player = player
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player?.replaceCurrentItem(with: AVPlayerItem(url: avURL))
    }
}
