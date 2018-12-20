import UIKit
import Auth0

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!

    
    var loginCredentials: Credentials!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.welcomeLabel.text = ""
        self.retrieveProfile()
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
                        self.welcomeLabel.text = "Welcome, \(profile.name ?? "no name")"
                        guard let pictureURL = profile.picture else { return }
                        let task = URLSession.shared.dataTask(with: pictureURL) { (data, response, error) in
                            guard let data = data , error == nil else { return }
                            DispatchQueue.main.async {
                                self.avatarImageView.image = UIImage(data: data)
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
