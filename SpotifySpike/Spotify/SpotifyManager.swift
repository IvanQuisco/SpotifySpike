//
//  SpotifyManager.swift
//  SpotifySpike
//
//  Created by Ivan Quintana on 02/12/21.
//

class SpotifyManager: NSObject {
    var appRemote: SPTAppRemote
    var accessToken: String!
    var currentURI = ""
    
    required init(appRemoteBuilder: AppRemoteBuilder) {
        self.appRemote = appRemoteBuilder.appRemote
    }
    
    public static var live: Self { .init(appRemoteBuilder: .live) }
}

extension SpotifyManager: SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {
    func connect() {
        appRemote.authorizeAndPlayURI(currentURI, asRadio: false, additionalScopes: SpotifyAuthKey.all)
    }
    
    func openURL(url: URL) {
        let parameters = appRemote.authorizationParameters(from: url);
    
        if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = access_token
            self.accessToken = access_token
        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print(error_description)
        }
    }

    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
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
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("disconnected")
    }
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("failed")
    }
}
