//
//  Untitled.swift
//  PremierSwift
//
//  Created by Sawan Rana on 31/01/25.
//  Copyright © 2025 Deliveroo. All rights reserved.
//

import UIKit

/**
 Extensions to simplify cell registration and dequeuing for UICollectionView.
 `dm_defaultIdentifier` provides a default reuse identifier for any UICollectionViewCell subclass.
 `dm_registerClassWithDefaultIdentifier` registers a UICollectionViewCell class with the default reuse identifier.
 `dm_dequeueReusableCellWithDefaultIdentifier` dequeues a cell using the default reuse identifier, and casts it to the appropriate cell type.
 */

extension UICollectionViewCell {
    @objc static var dm_defaultIdentifier: String { return String(describing: self) }
}

extension UICollectionView {
    func dm_registerClassWithDefaultIdentifier(cellClass: AnyClass) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.dm_defaultIdentifier)
    }
    
    func dm_dequeueReusableCellWithDefaultIdentifier<T: UICollectionViewCell>(at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.dm_defaultIdentifier, for: indexPath) as! T
    }
}
