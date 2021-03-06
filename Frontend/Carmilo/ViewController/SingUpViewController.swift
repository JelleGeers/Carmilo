import UIKit
import Auth0

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    
    @IBOutlet var actionButtons: [UIButton]!
    @IBOutlet var textFields: [UITextField]!
    
    var retrievedCredentials: Credentials?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actionButtons.forEach { $0.roundLaterals() }
        self.textFields.forEach { $0.setPlaceholderTextColor(.lightVioletColor()) }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func register(_ sender: UIButton) {
        self.performRegister()
    }
    
    @IBAction func registerWithFacebook(_ sender: UIButton) {
        self.performFacebookSignUp()
    }
    
    @IBAction func registerWithTwitter(_ sender: UIButton) {
        self.performTwitterSignUp()
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        self.validateForm()
    }
    
    fileprivate var loading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                if self.loading {
                    self.spinner.startAnimating()
                    self.actionButtons.forEach { $0.isEnabled = false }
                } else {
                    self.spinner.stopAnimating()
                    self.actionButtons.forEach { $0.isEnabled = true }
                }
            }
        }
    }
    
    //SOURCE: Deze methode werd mogelijk gemaakt door de implementatie van Auth0. OP de site heb ik verschillende methodes gevonden die het mogelijk maken om Auth0 te gebruiken
    //https://auth0.com/docs/quickstart/native/ios-swift
    fileprivate func performRegister() {
        self.view.endEditing(true)
        self.loading = true
        Auth0
            .authentication()
            .createUser(
                email: self.emailTextField.text!,
                password: self.passwordTextField.text!,
                connection: "Username-Password-Authentication",
                userMetadata: ["first_name": self.firstNameTextField.text!,
                               "last_name": self.lastNameTextField.text!]
            )
            .start { result in
                DispatchQueue.main.async {
                    self.loading = false
                    switch result {
                    case .success(let user):
                        self.showAlertForSuccess("User Sign up: \(user.email)")
                        self.performSegue(withIdentifier: "DismissSignUp", sender: nil)
                    case .failure(let error):
                        self.showAlertForError(error)
                    }
                }
        }
    }
    //SOURCE: Deze methode werd mogelijk gemaakt door de implementatie van Auth0. OP de site heb ik verschillende methodes gevonden die het mogelijk maken om Auth0 te gebruiken
    //https://auth0.com/docs/quickstart/native/ios-swift
    fileprivate func performFacebookSignUp() {
        self.view.endEditing(true)
        self.loading = true
        Auth0
            .webAuth()
            .connection("facebook")
            .scope("openid")
            .start { result in
                DispatchQueue.main.async {
                    self.loading = false
                    switch result {
                    case .success(let credentials):
                        self.retrievedCredentials = credentials
                        self.performSegue(withIdentifier: "DismissSignUp", sender: nil)
                    case .failure(let error):
                        self.showAlertForError(error)
                    }
                }
        }
    }
    //SOURCE: Deze methode werd mogelijk gemaakt door de implementatie van Auth0. OP de site heb ik verschillende methodes gevonden die het mogelijk maken om Auth0 te gebruiken
    //https://auth0.com/docs/quickstart/native/ios-swift
    fileprivate func performTwitterSignUp() {
        self.view.endEditing(true)
        self.loading = true
        Auth0
            .webAuth()
            .connection("twitter")
            .scope("openid")
            .start { result in
                DispatchQueue.main.async {
                    self.loading = false
                    switch result {
                    case .success(let credentials):
                        self.retrievedCredentials = credentials
                        self.performSegue(withIdentifier: "DismissSignUp", sender: nil)
                    case .failure(let error):
                        self.showAlertForError(error)
                    }
                }
        }
    }
    //SOURCE: Deze methode werd mogelijk gemaakt door de implementatie van Auth0. OP de site heb ik verschillende methodes gevonden die het mogelijk maken om Auth0 te gebruiken
    //https://auth0.com/docs/quickstart/native/ios-swift
    fileprivate func validateForm() {
        self.signUpButton.isEnabled = self.formIsValid
    }
    //SOURCE: Deze methode werd mogelijk gemaakt door de implementatie van Auth0. OP de site heb ik verschillende methodes gevonden die het mogelijk maken om Auth0 te gebruiken
    //https://auth0.com/docs/quickstart/native/ios-swift
    fileprivate var formIsValid: Bool {
        return self.emailTextField.hasText && self.passwordTextField.hasText && self.firstNameTextField.hasText && self.lastNameTextField.hasText
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.emailTextField:
            self.passwordTextField.becomeFirstResponder()
        case self.passwordTextField:
            self.firstNameTextField.becomeFirstResponder()
        case self.firstNameTextField:
            self.lastNameTextField.becomeFirstResponder()
        case self.lastNameTextField where self.formIsValid:
            self.performRegister()
        default:
            break
        }
        return true
    }
    
}
