//
//  ViewController.swift
//  FlashChat
//
//  Created by Димаш Алтынбек on 07.03.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    //MARK: -Views-
    let logoLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 50, weight: .bold)
        label.textColor = UIColor(named: "BrandBlue")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.titleLabel?.textColor = UIColor(named: "BrandBlue")
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .medium)
        button.backgroundColor = UIColor(named: "BrandLightBlue")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didRegisterTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .medium)
        button.backgroundColor = .systemTeal
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didLogInTapped), for: .touchUpInside)
        return button
    }()
    
    let logoText = "⚡️FlashChat"
    var charIdex = 0
    
    //MARK: -LifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setUpViews()
    }
    //MARK: -Functions-
    
    func setUpViews() {
        view.backgroundColor = .white
        view.addSubview(logoLabel)
        view.addSubview(registerButton)
        view.addSubview(logInButton)
        NSLayoutConstraint.activate([
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            logInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            logoLabel.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.bottomAnchor.constraint(equalTo: logInButton.topAnchor, constant: -5),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        //creating animation for logo label
        for letter in logoText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(charIdex), repeats: false) { timer in
                self.logoLabel.text?.append(letter)
                self.charIdex += 1
            }
        }
    }
    
    //MARK: -@objc functinos-
    @objc func didLogInTapped(_ sender: UIButton) {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didRegisterTapped(_ sender: UIButton) {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

