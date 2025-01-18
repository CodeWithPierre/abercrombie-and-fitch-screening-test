//
//  ANFExploreCardTableViewCell.swift
//  ANF Code Test
//
//  Created by Pierre ILYAMUKURU on 1/17/25.
//

import Foundation
import UIKit

class ANFExploreCardTableViewCell: UITableViewCell {
    static let maxConstraint: CGFloat = 50
    static let mediumConstraint: CGFloat = 16
    static let smallConstraint: CGFloat = 8
    static let xSmallConstraint: CGFloat = 4
    static let imageHeight: CGFloat = 200
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let topDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    let promoMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .black
        return label
    }()
    
    let bottomDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let shopMenButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("shopMenButton", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.darkGray.cgColor
        return button
    }()
    
    let shopWomenButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("shopWomenButton", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.darkGray.cgColor
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(topDescriptionLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(promoMessageLabel)
        contentView.addSubview(bottomDescriptionLabel)
        contentView.addSubview(buttonStackView)
        
        buttonStackView.addArrangedSubview(shopMenButton)
        buttonStackView.addArrangedSubview(shopWomenButton)
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.mediumConstraint),
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Self.mediumConstraint),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Self.mediumConstraint),
            backgroundImageView.heightAnchor.constraint(equalToConstant: Self.imageHeight),
            
            topDescriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            topDescriptionLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: Self.smallConstraint),
            topDescriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: Self.mediumConstraint),
            topDescriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -Self.mediumConstraint),
            
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topDescriptionLabel.bottomAnchor, constant: Self.xSmallConstraint),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: Self.mediumConstraint),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -Self.mediumConstraint),
            
            promoMessageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            promoMessageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Self.smallConstraint),
            promoMessageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: Self.mediumConstraint),
            promoMessageLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -Self.mediumConstraint),
            
            bottomDescriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bottomDescriptionLabel.topAnchor.constraint(equalTo: promoMessageLabel.bottomAnchor, constant: Self.xSmallConstraint),
            bottomDescriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: Self.mediumConstraint),
            bottomDescriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -Self.mediumConstraint),
            
            buttonStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonStackView.topAnchor.constraint(equalTo: bottomDescriptionLabel.bottomAnchor, constant: Self.mediumConstraint),
            buttonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Self.mediumConstraint),
            buttonStackView.heightAnchor.constraint(equalToConstant: 70),
            buttonStackView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(topDescription: String, title: String,
                   promoMessage: String, bottomDescription: String,
                   image: String?, shopMenButtonTitle: String, shopWomenButtonTitle: String) {
        topDescriptionLabel.text = topDescription
        titleLabel.text = title
        promoMessageLabel.text = promoMessage
        bottomDescriptionLabel.text = bottomDescription
        
        if let url = URL(string:  image ?? "") {
            ANFExploreCardImageService.shared.loadAsyncImage(from: url) { [weak self] image in
                guard let self = self, let image = image else {
                    self?.backgroundImageView.image = nil
                    return
                }
                backgroundImageView.image = image
            }
        }
        shopMenButton.setTitle(shopMenButtonTitle, for: .normal)
        shopWomenButton.setTitle(shopWomenButtonTitle, for: .normal)
    }
}
