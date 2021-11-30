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
    let app = Application()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    app.connect()
                }
                .onOpenURL { url in
                    app.openURL(url: url)
                }
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .background:
                app.willResignActive()
            case .inactive:
                print("Inactive")
            case .active:
                print("Active")
                app.didBecomeActive()
            @unknown default:
                print("Other")
            }
        }
    }
}
