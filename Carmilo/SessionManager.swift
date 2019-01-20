import Foundation
import SimpleKeychain
import Auth0
//SOURCE: Deze klasse werd mogelijk gemaakt door de implementatie van Auth0. OP de site heb ik verschillende methodes gevonden die het mogelijk maken om Auth0 te gebruiken
//https://auth0.com/docs/quickstart/native/ios-swift
enum SessionManagerError: Error {
    case noAccessToken
}

class SessionManager {
    static let shared = SessionManager()
    let keychain = A0SimpleKeychain(service: "Auth0")
    
    var profile: UserInfo?
    
    private init () { }
    
    func storeTokens(_ accessToken: String, idToken: String) {
        self.keychain.setString(accessToken, forKey: "access_token")
        self.keychain.setString(idToken, forKey: "id_token")
    }
    
    func retrieveProfile(_ callback: @escaping (Error?) -> ()) {
        guard let accessToken = self.keychain.string(forKey: "access_token") else {
            return callback(SessionManagerError.noAccessToken)
        }
        Auth0
            .authentication()
            .userInfo(withAccessToken: accessToken)
            .start { result in
                switch(result) {
                case .success(let profile):
                    self.profile = profile
                    callback(nil)
                case .failure(let error):
                    callback(error)
                }
        }
    }
    
    func logout() {
        self.keychain.clearAll()
    }
    
}
