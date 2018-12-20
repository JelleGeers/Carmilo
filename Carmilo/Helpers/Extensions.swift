import UIKit

extension UIViewController {
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func dismissNavigation(_ sender: AnyObject) {
        self.navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}

extension String {
    
    func attributedWithColor(_ color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
}

extension UIButton {
    
    func roundLaterals() {
        self.layer.cornerRadius = self.frame.size.height / 2
    }
    
}

extension UITextField {
    
    func setPlaceholderTextColor(_ color: UIColor) {
        guard let placeholder = self.placeholder else { return }
        self.attributedPlaceholder = placeholder.attributedWithColor(color)
    }
    
}

extension UIColor {
    
    class func lightVioletColor() -> UIColor {
        return UIColor(red: 173 / 255, green: 137 / 255, blue: 188 / 255, alpha: 1)
    }
    
    class func darkVioletColor() -> UIColor {
        return UIColor(red: 49 / 255, green: 49 / 255, blue: 80 / 255, alpha: 1)
    }
    
}

extension UIAlertController {
    
    static func loadingAlert() -> UIAlertController {
        return self.alertWithTitle("Loading", message: "Please, wait...")
    }
    
    static func alertWithTitle(_ title: String? = nil, message: String? = nil, includeDoneButton: Bool = false) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if includeDoneButton {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        }
        return alert
    }
    
    func presentInViewController(_ viewController: UIViewController, dismissAfter possibleDelay: TimeInterval? = nil, completion: (() -> ())? = nil) {
        viewController.present(self, animated: false, completion: nil)
        guard let delay = possibleDelay else {
            return
        }
        DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            self.dismiss(completion)
        }
    }
    
    func dismiss(_ completion: (()->())? = nil) {
        DispatchQueue.main.async {
            self.dismiss(animated: false, completion: completion)
        }
    }
    
}

func plistValues(bundle: Bundle) -> (clientId: String, domain: String)? {
    guard
        let path = bundle.path(forResource: "Auth0", ofType: "plist"),
        let values = NSDictionary(contentsOfFile: path) as? [String: Any]
        else {
            print("Missing Auth0.plist file with 'ClientId' and 'Domain' entries in main bundle!")
            return nil
    }
    
    guard
        let clientId = values["ClientId"] as? String,
        let domain = values["Domain"] as? String
        else {
            print("Auth0.plist file at \(path) is missing 'ClientId' and/or 'Domain' entries!")
            print("File currently has the following entries: \(values)")
            return nil
    }
    return (clientId: clientId, domain: domain)
}
