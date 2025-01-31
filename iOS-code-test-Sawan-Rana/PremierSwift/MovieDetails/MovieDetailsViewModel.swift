import Foundation

enum MoviesDetailsViewModelState {
    case loading(Movie)
    case loaded(MovieDetails)
    case error

    var title: String? {
        switch self {
        case .loaded(let movie):
            return movie.title
        case .loading(let movie):
            return movie.title
        case .error:
            return nil
        }
    }

    var movie: MovieDetails? {
        switch self {
        case .loaded(let movie):
            return movie
        case .loading, .error:
            return nil
        }
    }
}

final class MoviesDetailsViewModel {

    private let apiManager: APIManaging
    private let initialMovie: Movie

    init(movie: Movie, apiManager: APIManaging = APIManager()) {
        self.initialMovie = movie
        self.apiManager = apiManager
        self.state = .loading(movie)
    }

    var updatedState: (() -> Void)?

    var state: MoviesDetailsViewModelState {
        didSet {
            updatedState?()
        }
    }

    func fetchData() {
        apiManager.execute(MovieDetails.details(for: initialMovie)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieDetails):
                self.state = .loaded(movieDetails)
            case .failure:
                self.state = .error
            }
        }
    }
}
