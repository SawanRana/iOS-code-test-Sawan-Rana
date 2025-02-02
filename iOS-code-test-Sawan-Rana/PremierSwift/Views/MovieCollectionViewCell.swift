//
//  MovieCollectionViewCell.swift
//  PremierSwift
//
//  Created by Sawan Rana on 31/01/25.
//  Copyright © 2025 Deliveroo. All rights reserved.
//

import UIKit

/**
 Custom UICollectionViewCell for displaying a movie in a collection view.
 It includes a poster image, title, and a rating tag. The layout is managed
 using stack views, and the cell is configured with a Movie model that provides
 the necessary data for the poster, title, and rating.
 */

class MovieCollectionViewCell: UICollectionViewCell {
    
    let posterSize = CGSize(width: 92, height: 134)
    let titleLabel = UILabel()
    let genreLabel = UILabel()
    
    let imageStackView = UIStackView()
    let coverImage = UIImageView()
    let tagView = TagView()
    
    let containerStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        titleLabel.font = UIFont.Body.smallSemiBold
        titleLabel.textColor = UIColor.Text.charcoal
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        
        genreLabel.font = UIFont.Body.small
        genreLabel.textColor = UIColor.Text.grey
        genreLabel.numberOfLines = 0
        genreLabel.lineBreakMode = .byWordWrapping
        
        coverImage.contentMode = .scaleAspectFill
        coverImage.layer.cornerRadius = 8
        coverImage.layer.masksToBounds = true
        
        imageStackView.spacing = 10
        imageStackView.alignment = .leading
        imageStackView.axis = .vertical
        imageStackView.distribution = .fill
        
        containerStackView.alignment = .leading
        containerStackView.axis = .vertical
        containerStackView.spacing = 10
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        setupViewsHierarchy()
        setupConstraints()
    }
    
    func setupViewsHierarchy() {
        contentView.addSubview(containerStackView)
        imageStackView.dm_addArrangedSubviews(coverImage, titleLabel, tagView)
        containerStackView.dm_addArrangedSubviews(imageStackView)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: layoutMargins.top),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: layoutMargins.left),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -layoutMargins.right),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -layoutMargins.bottom),
            
        ])
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
//        genreLabel.isHidden = true
        tagView.configure(.rating(value: movie.voteAverage))
        if let path = movie.posterPath {
            coverImage.dm_setImage(posterPath: path)
        } else {
            coverImage.image = nil
        }
    }
}
