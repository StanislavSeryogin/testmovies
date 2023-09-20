import Alamofire
import Foundation

protocol MovieService {
    func fetchPopularMovies(page: Int) async throws -> [Movie]
    // Add other requests as necessary
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
}

struct MoviesResponse: Decodable {
    let results: [Movie]
}
