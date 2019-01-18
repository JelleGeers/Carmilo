//
//  Ride.swift
//  Carmilo
//
//  Created by Jelle Geers on 18/12/2018.
//  Copyright © 2018 Jelle Geers. All rights reserved.
//
import UIKit
import Auth0
class AllRidesTableViewController: UITableViewController {
    var loginCredentials: Credentials!
    
    var rides = [Ride]()
    var myIndex = 0
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Ride List"
        fetchJSON()
    }
    
    fileprivate func fetchJSON() {
        let urlString = "http://localhost:3000/API/rides/"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            DispatchQueue.main.async {
                
                if let err = err {
                    print("Failed to get data from url:", err)
                    return
                }

                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    self.rides = try decoder.decode([Ride].self, from: data)
                    self.tableView.reloadData()
                } catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                }
            }
            }.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rides.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        let ride = rides[indexPath.row]
        cell.textLabel?.text = ride.rides.departure
        cell.detailTextLabel?.text = String(ride.name + " " + ride.rides.date)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
    }
    
}

