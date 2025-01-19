//
//  ANFExploreCardTableViewCell.swift
//  ANF Code Test
//
//  Created by Pierre ILYAMUKURU on 1/17/25.
//

import Foundation
import UIKit

class ANFExploreCardTableViewCell: UITableViewCell {
    
    // Constants for consistent layout throughout the cell
    static let maxConstraint: CGFloat = 50
    static let mediumConstraint: CGFloat = 16
    static let smallConstraint: CGFloat = 8
    static let xSmallConstraint: CGFloat = 4
    static let imageHeight: CGFloat = 200
    static let openMenURL = "https://www.abercrombie.com/shop/us/mens-new-arrivals"
    static let openWomenURL = "https://www.abercrombie.com/shop/us/womens-new-arrivals"
    
    
    // MARK: - UI Elements
    
    // Background image view
    private(set) lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // Labels for various texts on the card
    private(set) lazy var topDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var promoMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var bottomDescriptionTextView: UITextView = {
        let bottomView = UITextView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.isEditable = false
        bottomView.isSelectable = true
        bottomView.isUserInteractionEnabled = true
        bottomView.dataDetectorTypes = .link
        bottomView.isScrollEnabled = false
        return bottomView
    }()
    
    // Stack view for buttons
    private(set) lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    // Shop buttons
    private(set) lazy var shopMenButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        return button
    }()
    
    private(set) lazy var shopWomenButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        return button
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(topDescriptionLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(promoMessageLabel)
        contentView.addSubview(bottomDescriptionTextView)
        contentView.addSubview(buttonStackView)
        
        buttonStackView.addArrangedSubview(shopMenButton)
        buttonStackView.addArrangedSubview(shopWomenButton)
        
        setupConstraints()
        
        shopMenButton.addTarget(self, action: #selector(openShopMenWebpage), for: .touchUpInside)
        shopWomenButton.addTarget(self, action: #selector(openShopWomenWebpage), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Setup
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Background image view constraints
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.mediumConstraint),
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Self.mediumConstraint),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Self.mediumConstraint),
            backgroundImageView.heightAnchor.constraint(equalToConstant: Self.imageHeight),
            
            // Top description label constraints
            topDescriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            topDescriptionLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: Self.smallConstraint),
            topDescriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: Self.mediumConstraint),
            topDescriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -Self.mediumConstraint),
            
            // Title label constraints
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topDescriptionLabel.bottomAnchor, constant: Self.xSmallConstraint),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: Self.mediumConstraint),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -Self.mediumConstraint),
            
            // Promo message label constraints
            promoMessageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            promoMessageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Self.smallConstraint),
            promoMessageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: Self.mediumConstraint),
            promoMessageLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -Self.mediumConstraint),
            
            // Bottom description label constraints
            bottomDescriptionTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bottomDescriptionTextView.topAnchor.constraint(equalTo: promoMessageLabel.bottomAnchor, constant: Self.xSmallConstraint),
            bottomDescriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.mediumConstraint),
            bottomDescriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Self.mediumConstraint),
            bottomDescriptionTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            // Button stack view constraints
            buttonStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonStackView.topAnchor.constraint(equalTo: bottomDescriptionTextView.bottomAnchor, constant: Self.mediumConstraint),
            buttonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Self.mediumConstraint),
            buttonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.mediumConstraint),
            buttonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Self.mediumConstraint)
        ])
    }
    
    // MARK: - Configuration Method
    
    /// Configure the cell with the given data.
    func configure(topDescription: String, title: String,
                   promoMessage: String?, bottomDescription: String?,
                   image: String?, shopMenButtonTitle: String, shopWomenButtonTitle: String) {
        topDescriptionLabel.text = topDescription
        titleLabel.text = title
        promoMessageLabel.text = promoMessage
        setBottomDescriptionText(bottomDescription)
        loadBackgroundImage(from: image)
        shopMenButton.setTitle(shopMenButtonTitle, for: .normal)
        shopWomenButton.setTitle(shopWomenButtonTitle, for: .normal)
        
        // Show or hide promo message label or hide bottom description text view
        promoMessageLabel.isHidden = promoMessage?.isEmpty ?? true
        if promoMessageLabel.isHidden {
            bottomDescriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Self.smallConstraint).isActive = true
        } else {
            bottomDescriptionTextView.topAnchor.constraint(equalTo: promoMessageLabel.bottomAnchor, constant: Self.xSmallConstraint).isActive = true
        }
        bottomDescriptionTextView.isHidden = bottomDescription?.isEmpty ?? true
        
        if bottomDescriptionTextView.isHidden && promoMessageLabel.isHidden {
            buttonStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Self.smallConstraint).isActive = true
        } else if promoMessageLabel.isHidden && !bottomDescriptionTextView.isHidden {
            buttonStackView.topAnchor.constraint(equalTo: bottomDescriptionTextView.bottomAnchor, constant: Self.xSmallConstraint).isActive = true
        } else if !promoMessageLabel.isHidden && bottomDescriptionTextView.isHidden {
            buttonStackView.topAnchor.constraint(equalTo: promoMessageLabel.bottomAnchor, constant: Self.smallConstraint).isActive = true
        } else {
            buttonStackView.topAnchor.constraint(equalTo: bottomDescriptionTextView.bottomAnchor, constant: Self.xSmallConstraint).isActive = true
        }
        layoutIfNeeded()
    }
    
    // MARK: - Helper Methods
    
    private func loadBackgroundImage(from imageUrl: String?) {
        backgroundImageView.image = UIImage()
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else {
            return
        }
        
        ANFExploreCardImageService.shared.loadAsyncImage(from: url) { [weak self] image in
            guard let self = self, let image = image else { return }
            self.backgroundImageView.image = image
        }
    }
    
    func setBottomDescriptionText(_ text: String?) {
        bottomDescriptionTextView.attributedText = (text.flatMap { convertHTMLToAttributedString(html: $0) })
    }
    
    private func convertHTMLToAttributedString(html: String) -> NSAttributedString? {
        guard let data = html.data(using: .utf8) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            return try NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
}
extension ANFExploreCardTableViewCell {
    // MARK: - Button Actions
    
    // Open the webpage when the openShopMenWebpage is tapped
    @objc private func openShopMenWebpage() {
        if let url = URL(string: Self.openMenURL) {
            UIApplication.shared.open(url)
        }
    }
    
    // Open the webpage when the openShopWomenWebpage is tapped
    @objc private func openShopWomenWebpage() {
        if let url = URL(string: Self.openWomenURL) {
            UIApplication.shared.open(url)
        }
    }
}
