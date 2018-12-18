//
//  ViewController.swift
//  swift4_1_json_decode
//
//  Created by Brian Voong on 4/2/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

class AllRidesTableViewController: UITableViewController {
    
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
        cell.textLabel?.text = ride.rides.destination
        cell.detailTextLabel?.text = String(ride.name + " " + ride.rides.date)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segueShowDetail", sender: self)
    }
    
}
