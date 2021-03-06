import UIKit
import Auth0
class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet var actionButtons: [UIButton]!
    @IBOutlet var textFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actionButtons.forEach { $0.roundLaterals() }
        self.textFields.forEach { $0.setPlaceholderTextColor(.lightVioletColor()) }
    }
    //SOURCE: Deze methoden werd mogelijk gemaakt door de implementatie van Auth0. OP de site heb ik verschillende methodes gevonden die het mogelijk maken om Auth0 te gebruiken
    //https://auth0.com/docs/quickstart/native/ios-swift
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func login(_ sender: UIButton) {
        self.performLogin()
    }
    
    @IBAction func loginWithFacebook(_ sender: UIButton) {
        self.performFacebookSignUp()
    }
    
    @IBAction func loginWithTwitter(_ sender: UIButton) {
        self.performTwitterAuthentication()
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        self.validateForm()
    }
    
    @IBAction func unwindToLogin(_ segue: UIStoryboardSegueWithCompletion) {
        guard let
            controller = segue.source as? SignUpViewController,
            let credentials = controller.retrievedCredentials
            else { return  }
        segue.completion = {
            self.loginWithCredentials(credentials)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let profileViewController = segue.destination as? ProfileViewController else {
            return
        }
        profileViewController.loginCredentials = self.retrievedCredentials!
    }
    
    fileprivate var retrievedCredentials: Credentials?
    
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
    
    fileprivate func performLogin() {
        self.view.endEditing(true)
        self.loading = true
        Auth0
            .authentication()
            .login(
                usernameOrEmail: self.emailTextField.text!,
                password: self.passwordTextField.text!,
                realm: "Username-Password-Authentication",
                scope: "openid profile")
            .start { result in
                DispatchQueue.main.async {
                    self.loading = false
                    switch result {
                    case .success(let credentials):
                        self.loginWithCredentials(credentials)
                    case .failure(let error):
                        self.showAlertForError(error)
                    }
                }
        }
    }
    
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
                        self.loginWithCredentials(credentials)
                    case .failure(let error):
                        self.showAlertForError(error)
                    }
                }
        }
    }
    
    fileprivate func performTwitterAuthentication() {
        self.view.endEditing(true)
        self.spinner.startAnimating()
        guard let clientInfo = plistValues(bundle: Bundle.main) else { return }
        Auth0
            .webAuth()
            .connection("twitter")
            .audience("https://" + clientInfo.domain + "/userinfo")
            .scope("openid")
            .start { result in
                DispatchQueue.main.async {
                    self.spinner.stopAnimating()
                    switch result {
                    case .success(let credentials):
                        self.loginWithCredentials(credentials)
                    case .failure(let error):
                        self.showAlertForError(error)
                    }
                }
        }
    }
    
    fileprivate func loginWithCredentials(_ credentials: Credentials) {
        self.retrievedCredentials = credentials
        self.performSegue(withIdentifier: "ShowProfile", sender: nil)
    }
    
    fileprivate func validateForm() {
        self.loginButton.isEnabled = self.formIsValid
    }
    
    fileprivate var formIsValid: Bool {
        return self.emailTextField.hasText && self.passwordTextField.hasText
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.emailTextField:
            self.passwordTextField.becomeFirstResponder()
        case self.passwordTextField where self.formIsValid:
            self.performLogin()
        default:
            break
        }
        return true
    }
    
}
