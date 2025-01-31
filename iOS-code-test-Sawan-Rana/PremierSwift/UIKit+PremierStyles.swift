import UIKit

extension UIColor {
    
    enum Text {
        static let charcoal: UIColor = UIColor.charcoal
        static let grey: UIColor = UIColor.grey
        static let white: UIColor = UIColor.white
    }
    
    enum Background {
        static let charcoal: UIColor = UIColor.charcoal
    }
    
    enum Brand {
        static let popsicle40: UIColor = UIColor.popsicle40
    }
    
    private static let charcoal: UIColor = UIColor(red: 22 / 255.0, green: 22 / 255.0, blue: 22 / 255.0, alpha: 1)
    private static let grey: UIColor = UIColor(red: 81 / 255.0, green: 81 / 255.0, blue: 83 / 255.0, alpha: 1)
    private static let popsicle40: UIColor = UIColor(red: 156 / 255.0, green: 44 / 255.0, blue: 243 / 255.0, alpha: 1)
    private static let white: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
}

extension UIFont {
    
    enum Heading {
        static var medium: UIFont = UIFont(name: "Poppins-SemiBold", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .semibold)
        static let small: UIFont = UIFont(name: "Poppins-SemiBold", size: 22) ?? UIFont.systemFont(ofSize: 22, weight: .semibold)
    }
    
    enum Body {
        static var small: UIFont = UIFont(name: "Poppins-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular)
        static var smallSemiBold: UIFont = UIFont(name: "Poppins-SemiBold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
   
}
