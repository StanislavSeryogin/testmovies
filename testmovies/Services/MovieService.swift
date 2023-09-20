import Alamofire
import Foundation

protocol MovieService {
    func fetchPopularMovies(page: Int) async throws -> [Movie]
    func searchMovies(term: String, page: Int) async throws -> [Movie]
}

struct AFMovieService: MovieService {
    
    func fetchPopularMovies(page: Int) async throws -> [Movie] {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(APIConstants.popularMoviesURL(page: page))
                .validate()
                .responseDecodable(of: MoviesResponse.self) { response in
                    switch response.result {
                    case .success(let moviesResponse):
                        continuation.resume(returning: moviesResponse.results)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func searchMovies(term: String, page: Int) async throws -> [Movie] {
        let url = APIConstants.searchMoviesURL(term: term, page: page)
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).validate().responseDecodable(of: MoviesResponse.self) { response in
                switch response.result {
                case .success(let moviesResponse):
                    continuation.resume(returning: moviesResponse.results)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

struct MoviesResponse: Decodable {
    let results: [Movie]
}
