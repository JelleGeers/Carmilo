//
//  LoginViewViewController.swift
//  Carmilo
//
//  Created by Jelle Geers on 19/12/2018.
//  Copyright © 2018 Jelle Geers. All rights reserved.
//

import UIKit
import Auth0

class LoginViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func login(_ sender: UIButton){
        self.performLogin()
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
