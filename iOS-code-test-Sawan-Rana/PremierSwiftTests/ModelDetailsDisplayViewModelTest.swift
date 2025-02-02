//
//  ModelDetailsDisplayViewModelTest.swift
//  PremierSwiftTests
//
//  Created by Sawan Rana on 01/02/25.
//  Copyright © 2025 Deliveroo. All rights reserved.
//

import XCTest
@testable import PremierSwift

let similarMoviesJsonString = """
{
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": null,
      "genre_ids": [18, 10752],
      "id": 936821,
      "original_language": "sk",
      "original_title": "Ostrov",
      "overview": "",
      "popularity": 0.295,
      "poster_path": null,
      "release_date": "1981-01-01",
      "title": "Ostrov",
      "video": false,
      "vote_average": 0.0,
      "vote_count": 0
    },
    {
      "adult": false,
      "backdrop_path": null,
      "genre_ids": [18, 10770],
      "id": 936824,
      "original_language": "sk",
      "original_title": "Pasca",
      "overview": "",
      "popularity": 1.014,
      "poster_path": null,
      "release_date": "1981-01-01",
      "title": "Pasca",
      "video": false,
      "vote_average": 2.0,
      "vote_count": 1
    }
  ],
  "total_pages": 13744,
  "total_results": 274868
}
"""

let similarMoviesJsonStringIncorrectFormat = """
{
  "pages": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": null,
      "genre_ids": [18, 10752],
      "id": 936821,
      "original_language": "sk",
      "original_title": "Ostrov",
      "overview": "",
      "popularity": 0.295,
      "poster_path": null,
      "release_date": "1981-01-01",
      "title": "Ostrov",
      "video": false,
      "vote_average": 0.0,
      "vote_count": 0
    },
    {
      "adult": false,
      "backdrop_path": null,
      "genre_ids": [18, 10770],
      "id": 936824,
      "original_language": "sk",
      "original_title": "Pasca",
      "overview": "",
      "popularity": 1.014,
      "poster_path": null,
      "release_date": "1981-01-01",
      "title": "Pasca",
      "video": false,
      "vote_average": 2.0,
      "vote_count": 1
    }
  ],
  "total_pages": 13744,
  "total_results": 274868
}
"""

final class MockApiManager: APIManaging {
    
    var simulateFailure: Bool = false
    
    static let shared = MockApiManager()
    
    func execute<Value>(_ request: PremierSwift.Request<Value>, completion: @escaping (Result<Value, PremierSwift.APIError>) -> Void) where Value : Decodable {
        if request.path.contains("similar") {
            let responseDataForSimilarMovies = responseDataForSimilarMovies()
            do {
                let value = try JSONDecoder().decode(Value.self, from: responseDataForSimilarMovies)
                completion(.success(value))
            } catch {
                completion(.failure(.parsingError))
            }
        }
    }
    
    private func responseDataForSimilarMovies() -> Data {
        
        if simulateFailure {
            return similarMoviesJsonStringIncorrectFormat.data(using: .utf8)!
        }
        
        return similarMoviesJsonString.data(using: .utf8)!
    }
}


final class ModelDetailsDisplayViewModelTest: XCTestCase {
    var sut: ModelDetailsDisplayViewModel!
    var apiManager: APIManaging!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setupSut()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        MockApiManager.shared.simulateFailure = false
        apiManager = nil
        sut = nil
    }
    
    private func setupSut() {
        apiManager = MockApiManager.shared
        sut = ModelDetailsDisplayViewModel(movieDetails: MovieDetails(id: 0, title: "testTitle", overview: "testOverview", backdropPath: "testBackDropPath", tagline: "testTagLine"), apiManager: apiManager)
    }
    
    func test_SUT_Initialization() {
        XCTAssertNotNil(sut)
    }
   
    func test_IntialState() {
        //Initial state is loading
        XCTAssertTrue(sut.state.isLoading)
        
        switch sut.state {
        case .loading(let movieDetails):
            XCTAssertEqual(movieDetails.id, sut._movieDetails.id)
            XCTAssertEqual(movieDetails.id, 0)
            XCTAssertEqual(movieDetails.title, "testTitle")
            XCTAssertEqual(movieDetails.overview, "testOverview")
            XCTAssertEqual(movieDetails.backdropPath, "testBackDropPath")
            XCTAssertEqual(movieDetails.tagline, "testTagLine")
        default:
            XCTFail()
        }
    }
    
    func test_updatedState_Binding() {
        let expectation = self.expectation(description: "updatedState")
        
        sut.updatedState = {
            expectation.fulfill()
        }
        
        sut.fetchSimilarMovies()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_fetchSimilarMovies_Success() {
        sut.fetchSimilarMovies()
        
        XCTAssertFalse(sut.state.isLoading)
        
        switch sut.state {
        case .loaded(let movies):
            XCTAssertTrue(!movies.isEmpty)
            XCTAssertEqual(movies.count, 2)
            XCTAssertEqual(movies.first?.title, "Ostrov")
        default:
            XCTFail()
        }
    }
    
    func test_fetchSimilarMovies_Failure() {
        
        MockApiManager.shared.simulateFailure = true
        
        sut.fetchSimilarMovies()
        
        switch sut.state {
        case .error(let error):
            XCTAssertTrue(error == .parsingError)
        default:
            XCTFail()
        }
    }

}
