//
//  AddRideViewController.swift
//  Carmilo
//
//  Created by Jelle Geers on 18/12/2018.
//  Copyright © 2018 Jelle Geers. All rights reserved.
//

import UIKit

class AddRideViewController: UIViewController {
    
    @IBOutlet weak var textfieldDestination: UITextField!
    
    @IBOutlet weak var textfieldDate: UITextField!
    
    
    @IBOutlet weak var textfieldStreet: UITextField!
    
    @IBOutlet weak var textfieldHousenr: UITextField!
    
    @IBOutlet weak var textfieldZipcode: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addRide(_ sender: UIButton) {
        guard let url = URL(string:"http://localhost:3000/API/rides/5c190a94f6611ca7b634e9b9/rides/") else { return }
        var request = URLRequest(url :url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let address = Address(street:self.textfieldStreet.text!, houseNr:self.textfieldHousenr.text!, zipcode:self.textfieldZipcode.text!)
        let rideInfo = RideInfo(destination:self.textfieldDestination.text!, date:self.textfieldDate.text!,address: address)
        do{
            let jsonBody = try JSONEncoder().encode(rideInfo)
            request.httpBody = jsonBody
        } catch {}
        
        let session = URLSession.shared
        let task = session.dataTask(with:request) { (data, _, _) in
            guard let data = data else { return }
            do {
                let sentPost = try JSONDecoder().decode(Ride.self, from: data)
                print(sentPost)
            }catch {}
        }
        task.resume()
        
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
