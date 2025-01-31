//
//  ModelDetailsDisplayViewModel.swift
//  PremierSwift
//
//  Created by Sawan Rana on 31/01/25.
//  Copyright © 2025 Deliveroo. All rights reserved.
//

import Foundation

/**
 ViewModel that manages the state and data for displaying movie details.
 It handles the loading state, fetching similar movies, and updates the state
 to notify observers of changes. The ViewModel interacts with an APIManager
 to fetch data, and uses closures to update the view when the state changes.
 
 The possible states for this ViewModel are:
 - `loading(MovieDetails)`: The initial state when movie details are being loaded.
 - `loaded([Movie])`: The state when similar movies are successfully loaded.
 - `error`: The state when there is an error fetching similar movies.
*/

enum ModelDetailsDisplayViewModelState {
    case loading(MovieDetails)  // State when movie details are being loaded
    case loaded([Movie])        // State when similar movies are loaded
    case error(APIError)        // State when an error occurs
    
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
}

final class ModelDetailsDisplayViewModel {

    private let apiManager: APIManaging  // Responsible for making API requests
    private let movieDetails: MovieDetails  // Movie details that will be displayed

    var _movieDetails: MovieDetails {
        movieDetails  // Exposes the movie details as a property
    }

    // Initializer to set up the ViewModel with the provided movie details
    // and an optional API manager (defaults to APIManager).
    init(movieDetails: MovieDetails, apiManager: APIManaging = APIManager()) {
        self.movieDetails = movieDetails
        self.apiManager = apiManager
        self.state = .loading(movieDetails)  // Set initial state to loading
    }

    // Closure that gets called when the state is updated
    var updatedState: (() -> Void)?

    // The current state of the ViewModel, triggers the updatedState closure when changed
    var state: ModelDetailsDisplayViewModelState {
        didSet {
            updatedState?()  // Notify observers when the state is updated
        }
    }

    // Fetches similar movies based on the current movie's ID using the APIManager
    func fetchSimilarMovies() {
        apiManager.execute(MovieDetails.similarMovies(for: movieDetails.id)) { [weak self] result in
            switch result {
            case .success(let page):
                self?.state = .loaded(page.results)  // Update state with the loaded movies
            case .failure(let apiError):
                self?.state = .error(apiError)  // Update state to error if the request fails
            }
        }
    }
}
