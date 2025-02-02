//
//  SimilarMoviesHeaderView.swift
//  PremierSwift
//
//  Created by Sawan Rana on 01/02/25.
//  Copyright © 2025 Deliveroo. All rights reserved.
//

import UIKit

/**
 A custom header view for displaying a "Similar Movies" section.
 It contains a label with the title "Similar Movies" and a button labeled "View all ->"
 that triggers an event when tapped. The event is passed to the parent view/controller
 through the eventHandler closure with a `viewAllTapped` event.
 */

enum SimilarMoviesHeaderViewEvent {
    case viewAllTapped
}

class SimilarMoviesHeaderView: UIView {
    let containerStackView = UIStackView()
    let textLabel = UILabel()
    let button = UIButton(type: .system)
    var eventHandler: ((SimilarMoviesHeaderViewEvent) -> Void)? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .clear
        
        textLabel.text = "Similar Movies"
        textLabel.font = UIFont.Heading.small
        textLabel.textColor = UIColor.Text.charcoal
        textLabel.numberOfLines = 1
        textLabel.lineBreakMode = .byWordWrapping
        
        button.setTitle("View all ->", for: .normal)
        button.setTitleColor(UIColor.Brand.popsicle40, for: .normal)
        button.titleLabel?.font = UIFont.Body.smallSemiBold
        button.isUserInteractionEnabled = true
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleViewAllTapped), for: .touchUpInside)
        
        containerStackView.axis = .horizontal
        containerStackView.distribution = .fillProportionally
        containerStackView.spacing = 8
        
        setupViewsHierarchy()
        setupConstraints()
    }
    
    @objc func handleViewAllTapped() {
        eventHandler?(.viewAllTapped)
    }
    
    private func setupViewsHierarchy() {
        addSubview(containerStackView)
        containerStackView.dm_addArrangedSubviews(textLabel, button)
    }
    
    private func setupConstraints() {
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}
