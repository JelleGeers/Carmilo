import UIKit
import Auth0

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    var loginCredentials: Credentials!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.welcomeLabel.text = ""
        self.retrieveProfile()
    }
    
    private func addUserToDatabase(profileEmail :String){
        guard let url = URL(string:"http://localhost:3000/API/users") else { return }
        var request = URLRequest(url :url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let user = User(name: "Test", email: profileEmail, ride: "[]")
        do{
            let jsonBody = try JSONEncoder().encode(user)
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
    
    
    // MARK: - Private
    
    fileprivate func retrieveProfile() {
        guard let accessToken = loginCredentials.accessToken else {
            print("Error retrieving profile")
            let _ = self.navigationController?.popViewController(animated: true)
            return
        }
        Auth0
            .authentication()
            .userInfo(withAccessToken: accessToken)
            .start { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let profile):
                        //Meegeven van het email adhv het token profil
                        self.addUserToDatabase(profileEmail: (profile.name ?? nil)!)
                        self.welcomeLabel.text = "Welcome, \(profile.name ?? "no name")"
                        guard let pictureURL = profile.picture else { return }
                        let task = URLSession.shared.dataTask(with: pictureURL) { (data, response, error) in
                            guard let data = data , error == nil else { return }
                            DispatchQueue.main.async {
        
                            }
                        }
                        task.resume()
                    case .failure(let error):
                        self.showAlertForError(error)
                    }
                }
        }
    }
    
}
