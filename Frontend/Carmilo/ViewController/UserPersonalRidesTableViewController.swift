import UIKit

class UserPersonalRidesTableViewController: UITableViewController {

    var rides = [RideInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Ride List"
        fetchJSON()
    }
    
    @IBAction func unwindToUserRides(segue:UIStoryboardSegue) {}
    
    override func viewWillAppear(_ animated: Bool) {
        fetchJSON()
    }
    @IBAction func logout(_ sender: UIBarButtonItem) {
        _ = SessionManager.shared.logout()
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    fileprivate func fetchJSON() {
        let urlString = "http://localhost:3000/API/rides/5c41f4d7fc176e0750077b8e/rides"
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
                    self.rides = try decoder.decode([RideInfo].self, from: data)
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
        let rideInfo = rides[indexPath.row]
        cell.textLabel?.text = rideInfo.departure
        cell.detailTextLabel?.text = String(rideInfo.departure + " " + rideInfo.date)
        return cell
    }
}
