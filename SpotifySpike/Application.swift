//
//  Application.swift
//  SpotifySpike
//
//  Created by Ivan Quintana on 29/11/21.
//

import Foundation

protocol LifeCycle {
    func onAppear()
    func didBecomeActive()
    func willResignActive()
    func onOpenURL(url: URL)
}

class Application: NSObject {
    let spotifyManager: SpotifyManager
    
    required init(spotifyManager: SpotifyManager) {
        self.spotifyManager = spotifyManager
        super.init()
    }
    
    static var live: Self { .init(spotifyManager: .live) }
}

extension Application: LifeCycle {
    func onAppear() {
        self.spotifyManager.connect()
    }
    
    func onOpenURL(url: URL) {
        self.spotifyManager.openURL(url: url)
    }
    
    func willResignActive() {
        if self.spotifyManager.appRemote.isConnected {
            self.spotifyManager.appRemote.disconnect()
        }
    }
    
    func didBecomeActive() {
        let isValidToken = self.spotifyManager.appRemote.connectionParameters.accessToken != nil
        if isValidToken {
            self.spotifyManager.appRemote.connect()
        }
    }
}
