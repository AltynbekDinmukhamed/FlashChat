//
//  RegisterViewController.swift
//  FlashChat
//
//  Created by Димаш Алтынбек on 08.03.2023.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    //MARK: -Views-
    let EmailView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "textfield")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let emialTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Emial"
        text.font = .systemFont(ofSize: 25, weight: .medium)
        text.textColor = UIColor(named: "BrandBlue")
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    //MARK: -secound view-
    let passwordView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "textfield")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let passwordTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Password"
        text.font = .systemFont(ofSize: 25, weight: .medium)
        text.textColor = UIColor(named: "BrandBlue")
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor(named: "BrandBlue"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(RegisterTapped), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: -LifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
    }
    
    //MARK: -Functinos-
    func setUpViews() {
        view.backgroundColor = UIColor(named: "BrandLightBlue")
        view.addSubview(EmailView)
        EmailView.addSubview(emailImageView)
        view.addSubview(emialTextField)
        NSLayoutConstraint.activate([
            EmailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            EmailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            EmailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            EmailView.heightAnchor.constraint(equalToConstant: 50),
            
            emailImageView.topAnchor.constraint(equalTo: EmailView.topAnchor),
            emailImageView.leadingAnchor.constraint(equalTo: EmailView.leadingAnchor),
            emailImageView.trailingAnchor.constraint(equalTo: EmailView.trailingAnchor),
            
            emialTextField.topAnchor.constraint(equalTo: EmailView.topAnchor, constant: 10),
            emialTextField.leadingAnchor.constraint(equalTo: EmailView.leadingAnchor),
            emialTextField.trailingAnchor.constraint(equalTo: EmailView.trailingAnchor),
        ])
        view.addSubview(passwordView)
        passwordView.addSubview(passwordImageView)
        passwordView.addSubview(passwordTextField)
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            passwordView.topAnchor.constraint(equalTo: EmailView.bottomAnchor, constant: 15),
            passwordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            passwordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            passwordView.heightAnchor.constraint(equalToConstant: 50),
            
            passwordImageView.topAnchor.constraint(equalTo: passwordView.topAnchor),
            passwordImageView.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor),
            passwordImageView.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor),
            
            registerButton.bottomAnchor.constraint(equalTo: passwordImageView.bottomAnchor, constant: 30),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
    
    @objc func RegisterTapped() {
        
        if let email = emialTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authData, error in
                if let e = error {
                    print(e.localizedDescription)
                    return
                } else {
                    let vc = ChatViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }

}
