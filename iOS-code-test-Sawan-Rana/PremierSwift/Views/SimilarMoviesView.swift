//
//  SimilarMoviesView.swift
//  PremierSwift
//
//  Created by Sawan Rana on 31/01/25.
//  Copyright © 2025 Deliveroo. All rights reserved.
//

import UIKit

/**
 A custom stack view that displays a section for similar movies.
 The view includes a header view ("Similar Movies") and a horizontally scrollable
 collection view that displays a list of similar movies. The movies are passed
 through the `similarMovies` property, which reloads the collection view whenever updated.
 */

class SimilarMoviesView: UIStackView {
    let similarMoviesHeaderView = SimilarMoviesHeaderView()
    
    var similarMovies: [Movie] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    private(set) var collectionView:UICollectionView? = nil
    private(set) var flowLayout:UICollectionViewFlowLayout! = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        axis = .vertical
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        
        setupCollectionView()
        
        setupViewsHierarchy()
        setupConstraints()
    }
    
    private func setupCollectionView() {
        collectionView?.removeFromSuperview()
        
        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 16, height: UIScreen.main.bounds.height * 0.35)

        self.flowLayout = flowLayout
        
        let collectionView:UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.dm_registerClassWithDefaultIdentifier(cellClass: MovieCollectionViewCell.self)
        
        self.collectionView = collectionView
    }
    
    private func setupViewsHierarchy() {
        dm_addArrangedSubviews(similarMoviesHeaderView, collectionView!)
    }
    
    private func setupConstraints() {
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView!.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.4)
        ])
    }
}

extension SimilarMoviesView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moviesCollectionViewCell: MovieCollectionViewCell = collectionView.dm_dequeueReusableCellWithDefaultIdentifier(at: indexPath)
        
        moviesCollectionViewCell.configure(with: similarMovies[indexPath.row])
        return moviesCollectionViewCell
    }
}
