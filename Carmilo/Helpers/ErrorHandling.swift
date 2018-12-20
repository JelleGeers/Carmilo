import UIKit
import Auth0

extension UIViewController {
    
    func showAlertForError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: "Failed with error: \(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertForSuccess(_ msg: String) {
        let alert = UIAlertController(title: "Success", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
