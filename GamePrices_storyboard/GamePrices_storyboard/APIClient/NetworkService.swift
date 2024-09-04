//
//  NetworkService.swift
//  GamePrices_storyboard
//
//  Created by Egor Moroz on 21.08.24.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    
    private init () {}
    
    enum ServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    public func execute<T: Decodable>(
        _ request: Request,
        expecting type: T.Type,
        completion: @escaping(Result<T, Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private func request(from gRequest: Request) -> URLRequest? {
        guard let url = gRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = gRequest.httpMethod
        
        return request
    }
    
}
