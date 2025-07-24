//
//  SharedDuckApp.swift
//  SharedDuck
//
//  Created by John Brewer on 6/12/25.
//

import SwiftUI
import GroupActivities
import AVFAudio
import AVFoundation

nonisolated
struct DuckActivity: GroupActivity, Transferable {
    var metadata: GroupActivityMetadata {
        var metadata = GroupActivityMetadata()
        metadata.title = "Share the Duck"
        metadata.type = .generic
        return metadata
    }
}

@main
struct SharedDuckApp: App {

    @State private var appModel = AppModel()

    let quackPlayer: AVAudioPlayer?
    
    init() {
        print("init called")
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback)
            try session.setActive(true)
            try session.setIntendedSpatialExperience(.bypassed)
            let path = Bundle.main.path(forResource: "quack", ofType: "mp3")
            let url = URL(fileURLWithPath: path!)
            let data = try Data(contentsOf: url)
            quackPlayer = try AVAudioPlayer(contentsOf: url)
            quackPlayer?.prepareToPlay()
        } catch {
            print("Error = \(error)")
            quackPlayer = nil
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
            ShareLink(item: DuckActivity(), preview: SharePreview("Share Preview"))
                .hidden()
        }
        .windowStyle(.volumetric)
        
        Window("Control Panel", id: "control-panel") {
            ControlPanelView(quackPlayer: quackPlayer!)
        }
        .windowResizability(.contentSize)

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
    }
}
