//
//  Application.swift
//  SpotifySpike
//
//  Created by Ivan Quintana on 29/11/21.
//

import Foundation

class Application: NSObject, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {
    let SpotifyClientID = "28f4cedefcb34df4bdde7a12e23c2b5e"
    let SpotifyRedirectURL = URL(string: "spotify-spike://spotify-login-callback")!
    var accessToken: String!
    var playURI = ""

    lazy var configuration = SPTConfiguration(
      clientID: SpotifyClientID,
      redirectURL: SpotifyRedirectURL
    )
    
    lazy var appRemote: SPTAppRemote = {
      let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
      appRemote.connectionParameters.accessToken = self.accessToken
      appRemote.delegate = self
      return appRemote
    }()
    
    func openURL (url: URL) {
        let parameters = appRemote.authorizationParameters(from: url);
    
        if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = access_token
            self.accessToken = access_token
        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print(error_description)
        }
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
      print("disconnected")
    }
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
      print("failed")
    }

    func connect() {
        appRemote.authorizeAndPlayURI(
            "",
            asRadio: false,
            additionalScopes: [
                "playlist-read-private",
                "user-read-private",
                "user-read-email",
                "playlist-modify-public",
                "playlist-modify-private"
            ]
        )
    }
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
      // Connection was successful, you can begin issuing commands
      self.appRemote.playerAPI?.delegate = self
      self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
        if let error = error {
          debugPrint(error.localizedDescription)
        }
      })
    }
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
      debugPrint("Track name: %@", playerState.track.name)
    }
    
    func willResignActive() {
      if self.appRemote.isConnected {
        self.appRemote.disconnect()
      }
    }
    
    func didBecomeActive() {
      if let _ = self.appRemote.connectionParameters.accessToken {
        self.appRemote.connect()
      }
    }
}
