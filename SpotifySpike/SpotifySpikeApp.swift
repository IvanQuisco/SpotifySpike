//
//  SpotifySpikeApp.swift
//  SpotifySpike
//
//  Created by Ivan Quintana on 29/11/21.
//

import SwiftUI

@main
struct SpotifySpikeApp: App {
    @Environment(\.scenePhase) private var scenePhase
    let app = Application.live
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear { app.onAppear() }
                .onOpenURL { app.onOpenURL(url: $0) }
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .background:
                app.willResignActive()
            case .active:
                app.didBecomeActive()
            default:
                break
            }
        }
    }
}
