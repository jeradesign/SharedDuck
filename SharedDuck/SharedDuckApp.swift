//
//  SharedDuckApp.swift
//  SharedDuck
//
//  Created by John Brewer on 6/12/25.
//

import SwiftUI
import GroupActivities

struct DuckActivity: GroupActivity, Transferable {
    var metadata = GroupActivityMetadata()
}

@main
struct SharedDuckApp: App {

    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
            ShareLink(item: DuckActivity(), preview: SharePreview("Share the Duck"))
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
