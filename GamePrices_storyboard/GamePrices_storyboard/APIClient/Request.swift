//
//  Request.swift
//  GamePrices_storyboard
//
//  Created by Egor Moroz on 21.08.24.
//

import Foundation

final class Request {
    
    private let baseUrl = "https://www.cheapshark.com/api/1.0"
    
    private let endpoint: GEndpoint
    
    private let queryParameters: [URLQueryItem]
    
    private var urlString: String {
        var string = baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !queryParameters.isEmpty {
            string += "?"
            
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
    public init(endpoint: GEndpoint, queryParameters: [URLQueryItem]) {
        self.endpoint = endpoint
        self.queryParameters = queryParameters
    }
    
}
