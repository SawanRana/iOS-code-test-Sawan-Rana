import UIKit

final class MovieDetailsViewController: UIViewController {

    private let viewModel: MoviesDetailsViewModel
    private var currentViewController: UIViewController!

    init(viewModel: MoviesDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        navigationItem.largeTitleDisplayMode = .never
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem.backButton(target: self, action: #selector(didTapBack(_:)))
        updateFromViewModel()
        bindViewModel()
        viewModel.fetchData()
    }

    private func bindViewModel() {
        viewModel.updatedState = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.updateFromViewModel()
            }
        }
    }

    private func updateFromViewModel() {
        let state = viewModel.state
        title = state.title
        switch state {
        case .loading(let movie):
            self.showLoading(movie)
        case .loaded(let details):
            self.showMovieDetails(details)
        case .error:
            self.showError()
        }
    }

    private func showLoading(_ movie: Movie) {
        let loadingViewController = LoadingViewController()
        addChild(loadingViewController)
        loadingViewController.view.frame = view.bounds
        loadingViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(loadingViewController.view)
        loadingViewController.didMove(toParent: self)
        currentViewController = loadingViewController
    }

    private func showMovieDetails(_ movieDetails: MovieDetails) {
        let displayViewController = MovieDetailsDisplayViewController(movieDetails: movieDetails)
        addChild(displayViewController)
        displayViewController.view.frame = view.bounds
        displayViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        currentViewController?.willMove(toParent: nil)
        transition(
            from: currentViewController,
            to: displayViewController,
            duration: 0.25,
            options: [.transitionCrossDissolve],
            animations: nil
        ) { (_) in
            self.currentViewController.removeFromParent()
            self.currentViewController = displayViewController
            self.currentViewController.didMove(toParent: self)
        }
    }

    private func showError() {
        let alertController = UIAlertController(title: "", message: LocalizedString(key: "moviedetails.load.error.body"), preferredStyle: .alert)
        let alertAction = UIAlertAction(title: LocalizedString(key: "moviedetails.load.error.actionButton"), style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }

    @objc private func didTapBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}
