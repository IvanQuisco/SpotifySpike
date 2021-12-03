//
//  AppRemoteBuilder.swift
//  SpotifySpike
//
//  Created by Ivan Quintana on 02/12/21.
//

struct AppRemoteBuilder {
    var appRemote: SPTAppRemote
    
    private init(clientId: String, redirectURL: URL, logLevel: SPTAppRemoteLogLevel = .debug) {
        let configuration = SPTConfiguration(clientID: clientId, redirectURL: redirectURL)
        self.appRemote = .init(configuration: configuration, logLevel: logLevel)
    }
    
    static let live: Self = .init(clientId: ClientConstants.id, redirectURL: ClientConstants.redirectURL)
}
