import UIKit

extension UITableViewCell {
    // swiftlint:disable:next identifier_name
    @objc static var dm_defaultIdentifier: String { return String(describing: self) }
}

extension UITableView {
    
    func dm_registerClassWithDefaultIdentifier(cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: cellClass.dm_defaultIdentifier)
    }
    
    func dm_dequeueReusableCellWithDefaultIdentifier<T: UITableViewCell>() -> T {
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withIdentifier: T.dm_defaultIdentifier) as! T
    }
    
}
