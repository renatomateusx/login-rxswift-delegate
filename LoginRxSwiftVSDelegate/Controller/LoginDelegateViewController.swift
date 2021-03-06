//
//  LoginDelegateViewController.swift
//  LoginRxSwiftVSDelegate
//
//  Created by Renato Mateus on 17/03/21.
//

import UIKit
import SafariServices
class LoginDelegateViewController: UIViewController {
    
    private let viewModel = LoginDelegateViewModel()
    
    var topSafeArea: CGFloat = 0.0
    var bottomSafeArea: CGFloat = 0.0
    
    
    private let userNameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = UIColor.white
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.lightGray.cgColor
       return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = UIColor.white
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.lightGray.cgColor
        return field
    }()
    
    private  let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In With Delegate", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private  let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        return button
    }()
    
    private  let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        return button
    }()
    
    private  let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("New User? Create an Acount", for: .normal)
        button.setTitleColor(UIColor.lightText, for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundimageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundimageView)
        return header
    }()
    
    private let dimmeView: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .blue
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        viewModel.delegate = self
        loginButton.addTarget(self, action: #selector(didTapLogginButton), for: .touchUpInside)
//        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        
        userNameEmailField.delegate = self
        passwordField.delegate = self
        addSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        getSafeAreas()
        headerView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height / 3.0)
        
        userNameEmailField.frame = CGRect(x: 25, y: headerView.bottom + 40, width: view.width - 50, height: 52.0)
        passwordField.frame = CGRect(x: 25, y: userNameEmailField.bottom + 10, width: view.width - 50, height: 52.0)
        
        loginButton.frame = CGRect(x: 25, y: passwordField.bottom + 10, width: view.width - 50, height: 52.0)
        
        createAccountButton.frame = CGRect(x: 25, y: loginButton.bottom + 10, width: view.width - 50, height: 52.0)
        
        termsButton.frame = CGRect(x: 10, y: view.height - bottomSafeArea-100, width: view.width - 20, height: 50)
        privacyButton.frame = CGRect(x: 10, y: view.height - bottomSafeArea-50, width: view.width - 20, height: 50)
        
        dimmeView.frame = view.bounds
        
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
        
        configureHeaderView()
    }
    
    private func configureHeaderView(){
        guard headerView.subviews.count == 1 else {return}
        guard let backgroundView = headerView.subviews.first else {return}
        backgroundView.frame = headerView.bounds
        
        //Insta Logo
        let imageView = UIImageView(image: UIImage(named: "instaLogo2"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4.0, y: topSafeArea, width: headerView.width / 2, height: headerView.height - topSafeArea)
    }
    
    private func addSubViews(){
        view.addSubview(userNameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
        view.addSubview(dimmeView)
        view.addSubview(spinner)
    }
    
    @objc private func didTapLogginButton(){
        configureDimme(false)
        spinner.startAnimating()
        
        passwordField.resignFirstResponder()
        userNameEmailField.resignFirstResponder()
        guard let userNameEmail = userNameEmailField.text, !userNameEmail.isEmpty, let password = passwordField.text, !password.isEmpty, password.count >= 8 else {return}
        
        //MARK: Login Functionality
        var username: String?
        var email: String?
        if userNameEmail.isEmail() {
            email = userNameEmail
        }else{
            username = userNameEmail
        }
        
        viewModel.doLogin(user: User(username: username, email: email, password: password))
    }
    @objc private func didTapTermsButton(){
        guard let url = URL(string: "https://help.instagram.com/581066165581870?helpref=page_content") else {return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    @objc private func didTapPrivacyButton(){
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else {return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    private func configureDimme(_ show: Bool){
        if !show {
            dimmeView.isHidden = false
            UIView.animate(withDuration: 0.2) {
                self.dimmeView.alpha = 0.4
            }
        }
        else{
            UIView.animate(withDuration: 0.2, animations: {
                self.dimmeView.alpha = 0
            }) { done in
                if done {
                    self.dimmeView.isHidden = true
                }
            }
        }
    }
    

}
extension LoginDelegateViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameEmailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapLogginButton()
        }
        return true
    }
}

extension LoginDelegateViewController {
    public func getSafeAreas() {

        if #available(iOS 11.0, *) {
            self.topSafeArea = view.safeAreaInsets.top
            self.bottomSafeArea = view.safeAreaInsets.bottom
        } else {
            self.topSafeArea = topLayoutGuide.length
            self.bottomSafeArea = bottomLayoutGuide.length
        }
    }
}

extension LoginDelegateViewController: ResultLogin {
    func doResult(result: UserResult) {
        configureDimme(true)
        spinner.stopAnimating()
        if result.result {
            let alert = UIAlertController(title: "Log In By Delegate", message: "We logged you Successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        else {
            let alert = UIAlertController(title: "Log In Error", message: "We were unable to log you in", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    
}
