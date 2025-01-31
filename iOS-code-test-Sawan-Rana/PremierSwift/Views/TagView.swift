import UIKit

final class TagView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ style: Style) {
        backgroundColor = style.backgroundColor
        iconView.tintColor = style.tintColor
        iconView.image = style.icon
        iconView.isHidden = style.icon == nil
        textLabel.textColor = style.tintColor
        textLabel.text = style.text
    }
    
    private let stackView: UIStackView = UIStackView()
    private let iconView: UIImageView = UIImageView()
    private let textLabel: UILabel = UILabel()
    
    private func commonInit() {
        layoutMargins = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        
        layer.cornerRadius = 4
        
        iconView.contentMode = .scaleAspectFit
        
        textLabel.font = UIFont.Body.smallSemiBold
        textLabel.baselineAdjustment = .alignCenters
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.dm_addArrangedSubviews(iconView, textLabel)
        
        addSubview(stackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

extension TagView {
    
    enum Style {
        case rating(value: Double)
        
        fileprivate var backgroundColor: UIColor {
            switch self {
            case .rating:
                return UIColor.Background.charcoal
            }
        }
        
        fileprivate var tintColor: UIColor {
            switch self {
            case .rating:
                return UIColor.Text.white
            }
        }
        
        fileprivate var icon: UIImage? {
            switch self {
            case .rating:
                return UIImage(named: "Star")?.withRenderingMode(.alwaysTemplate)
            }
        }
        
        fileprivate var text: String {
            switch self {
            case .rating(let value):
                return String(format: "%.1f", value)
            }
        }
    }
}
