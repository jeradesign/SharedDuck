//
//  SharedDuckApp.swift
//  SharedDuck
//
//  Created by John Brewer on 6/12/25.
//

import SwiftUI
import GroupActivities

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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
            ShareLink(item: DuckActivity(), preview: SharePreview("Share Preview"))
                .hidden()
        }
        .windowStyle(.volumetric)

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
