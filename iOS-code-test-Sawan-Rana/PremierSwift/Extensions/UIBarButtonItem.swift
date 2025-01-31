import UIKit

extension UIBarButtonItem {
    static func backButton(target: Any?, action: Selector?) -> UIBarButtonItem {
        let backButton = UIBarButtonItem(image: UIImage(named: "ArrowLeft"), style: .plain, target: target, action: action)
        backButton.tintColor = UIColor.Brand.popsicle40
        return backButton
    }
}

