//
//  HomeViewController.swift
//  Carmilo
//
//  Created by Jelle Geers on 19/12/2018.
//  Copyright © 2018 Jelle Geers. All rights reserved.
//

import UIKit
import Auth0
class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // HomeViewController.swift
        // Create an instance of the credentials manager for storing credentials
        
        Auth0
            .webAuth()
            .scope("openid profile offline_access")
            .audience("https://appswiftandroid.eu.auth0.com/userinfo")
            .start {
                switch $0 {
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                case .success(let credentials):
                    // Auth0 will automatically dismiss the login page
                    // Store the credentials
                    credentialsManager.store(credentials: credentials)
                }
        }
        }

        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
