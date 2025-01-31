import UIKit

extension UIView {
    
    func dm_addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            addSubview(subview)
        }
    }
    
}

extension UIStackView {
    
    func dm_addArrangedSubviews(_ subviews: UIView...) {
        for subview in subviews {
            addArrangedSubview(subview)
        }
    }
    
}
