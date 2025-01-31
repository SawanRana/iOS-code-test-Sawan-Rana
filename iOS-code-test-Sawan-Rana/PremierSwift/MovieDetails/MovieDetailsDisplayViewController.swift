import UIKit

final class MovieDetailsDisplayViewController: UIViewController {
    
    let movieDetails: MovieDetails
    
    init(movieDetails: MovieDetails) {
        self.movieDetails = movieDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = View()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (view as? View)?.configure(movieDetails: movieDetails)
    }
    
    private class View: UIView {
        
        let scrollView = UIScrollView()
        let backdropImageView = UIImageView()
        let titleLabel = UILabel()
        let overviewLabel = UILabel()
        private lazy var contentStackView = UIStackView(arrangedSubviews: [backdropImageView, titleLabel, overviewLabel])
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        
        private func commonInit() {
            backgroundColor = .white
            
            backdropImageView.contentMode = .scaleAspectFill
            backdropImageView.clipsToBounds = true
            
            titleLabel.font = UIFont.Heading.medium
            titleLabel.textColor = UIColor.Text.charcoal
            titleLabel.numberOfLines = 0
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.setContentHuggingPriority(.required, for: .vertical)
            
            overviewLabel.font = UIFont.Body.small
            overviewLabel.textColor = UIColor.Text.grey
            overviewLabel.numberOfLines = 0
            overviewLabel.lineBreakMode = .byWordWrapping
            
            contentStackView.axis = .vertical
            contentStackView.spacing = 24
            contentStackView.setCustomSpacing(8, after: titleLabel)
            
            setupViewsHierarchy()
            setupConstraints()
        }
        
        private func setupViewsHierarchy() {
            addSubview(scrollView)
            scrollView.addSubview(contentStackView)
        }
        
        private func setupConstraints() {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            backdropImageView.translatesAutoresizingMaskIntoConstraints = false
            contentStackView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate(
                [
                    scrollView.topAnchor.constraint(equalTo: topAnchor),
                    scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
                    scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    
                    backdropImageView.heightAnchor.constraint(equalTo: backdropImageView.widthAnchor, multiplier: 11 / 16, constant: 0),
                    
                    contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
                    contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                    contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                    contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -24)
                ]
            )
            
            scrollView.layoutMargins = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
            preservesSuperviewLayoutMargins = false
        }
        
        func configure(movieDetails: MovieDetails) {
            backdropImageView.dm_setImage(backdropPath: movieDetails.backdropPath)
            
            titleLabel.text = movieDetails.title
            
            overviewLabel.text = movieDetails.overview
        }
    }
    
}

