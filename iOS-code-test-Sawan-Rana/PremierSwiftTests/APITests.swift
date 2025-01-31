import XCTest
@testable import PremierSwift

final class APITests: XCTestCase {
    func test_url_queryParams() {
        let queryItem = URLQueryItem(name: "testName", value: "testValue")
        let url = URL(string: "https://deliveroo.co.uk")!.url(with: [queryItem])
        XCTAssertEqual(url.absoluteString, "https://deliveroo.co.uk?testName=testValue")
    }
    
    func test_full_url_builder() {
        let request: Request<Movie> = Request(method: .get, path: "/testing")
        let url = URL("https://deliveroo.co.uk", "testKey", request)
        XCTAssertEqual(url.absoluteString, "https://deliveroo.co.uk/testing?api_key=testKey")
    }
}
