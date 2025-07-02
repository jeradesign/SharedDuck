//
//  ControlPanelView.swift
//  SharedDuck
//
//  Created by John Brewer on 6/13/25.
//

import SwiftUI
import AVFoundation

struct ControlPanelView: View {
    let quackPlayer: AVAudioPlayer
    
    var body: some View {
        Button("Quack") {
            print("quackPlayer = \(String(describing: quackPlayer))")
            quackPlayer.play()
        }
        .frame(minWidth: 500, maxWidth: 500, minHeight: 200, maxHeight: 200)
    }
}

#Preview {
    ControlPanelView(quackPlayer: AVAudioPlayer())
}
