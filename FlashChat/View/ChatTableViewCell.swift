//
//  ChatTableViewCell.swift
//  FlashChat
//
//  Created by Димаш Алтынбек on 11.03.2023.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    //MARK: -Views-

    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
//    let labelView: UIView = {
//        let label = UIView()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    let labelText: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.textColor = UIColor(named: "BrandBlue")
        label.backgroundColor = UIColor(named: "BrandPurple")
        label.numberOfLines = 0
        label.layer.cornerRadius = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "MeAvatar")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let secoundLogoImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "YouAvatar")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: -LifeCycle-
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: -Functions-
    func setUpViews() {
        addSubview(mainStack)
        mainStack.addArrangedSubview(secoundLogoImageView)
        mainStack.addArrangedSubview(labelText)
        //labelView.addSubview(labelText)
        mainStack.addArrangedSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
//            labelView.topAnchor.constraint(equalTo: mainStack.topAnchor),
//            labelView.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
//            labelView.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor),
//            labelView.trailingAnchor.constraint(equalTo: logoImageView.leadingAnchor, constant: -5),
            
            labelText.topAnchor.constraint(equalTo: mainStack.topAnchor, constant: 5),
            labelText.leadingAnchor.constraint(equalTo: secoundLogoImageView.leadingAnchor, constant: 10),
            labelText.trailingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: -10),
            labelText.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: -5),
            
            logoImageView.widthAnchor.constraint(equalToConstant: 40),
            logoImageView.heightAnchor.constraint(equalToConstant: 40),
            logoImageView.topAnchor.constraint(equalTo: mainStack.topAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: labelText.trailingAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor),
            
            secoundLogoImageView.widthAnchor.constraint(equalToConstant: 40),
            secoundLogoImageView.heightAnchor.constraint(equalToConstant: 40),
            secoundLogoImageView.topAnchor.constraint(equalTo: mainStack.topAnchor),
            secoundLogoImageView.trailingAnchor.constraint(equalTo: labelText.leadingAnchor),
            secoundLogoImageView.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            secoundLogoImageView.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor)
        ])
    }
}
