//
//  AuthKeys.swift
//  SpotifySpike
//
//  Created by Ivan Quintana on 02/12/21.
//

enum SpotifyAuthKey: String, CaseIterable {
    case playlistReadPrivate = "playlist-read-private"
    case userReadPrivate = "user-read-private"
    case userReadEmail = "user-read-email"
    case playlistModifyPublic = "playlist-modify-public"
    case playlistModifyPrivate = "playlist-modify-private"
    
    static var all: [String]  {
        Self.allCases.map(\.rawValue)
    }
}
