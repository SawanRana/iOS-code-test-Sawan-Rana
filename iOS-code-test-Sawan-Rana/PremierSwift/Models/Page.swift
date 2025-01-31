import Foundation

struct Page<T: Decodable>: Decodable {
    
    let pageNumber: Int
    let totalResults: Int
    let totalPages: Int
    let results: [T]
    
    enum CodingKeys: String, CodingKey {
        case pageNumber = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
}
