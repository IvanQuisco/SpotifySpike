//
//  ClientConstants.swift
//  SpotifySpike
//
//  Created by Ivan Quintana on 02/12/21.
//

enum ClientConstants {
    static let id = "28f4cedefcb34df4bdde7a12e23c2b5e"
    
    static var redirectURL: URL = URL(string: "spotify-spike://\(callback)")! // Fix unwrapping
    
    private static let callback = "spotify-login-callback"
}
