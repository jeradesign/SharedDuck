//
//  ContentView.swift
//  SharedDuck
//
//  Created by John Brewer on 6/12/25.
//

import SwiftUI
import RealityKit
import RealityKitContent
import GroupActivities

struct ContentView: View {

    @State private var enlarge = false
    @State private var session: GroupSession<DuckActivity>? = nil
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                content.add(scene)
            }
        } update: { content in
            // Update the RealityKit content when SwiftUI state changes
            if let scene = content.entities.first {
                let uniformScale: Float = enlarge ? 1.4 : 1.0
                scene.transform.scale = [uniformScale, uniformScale, uniformScale]
            }
        }
        .gesture(TapGesture().targetedToAnyEntity().onEnded { _ in
            enlarge.toggle()
        })
        .onAppear {
            openWindow(id: "control-panel")
        }
        .task {
            for await session in DuckActivity.sessions() {
                self.session = session
                session.join()
            }
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
        .environment(AppModel())
}
