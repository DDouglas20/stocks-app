//
//  APICaller.swift
//  Stocks
//
//  Created by DeQuan Douglas on 7/14/21.
//

import Foundation


final class APICaller {
    static let shared = APICaller()
    
    private struct Constants {
        static let apiKey = "c3vmjt2ad3ia9vcceq20"
        static let sandboxApiKey = "sandbox_c3vmjt2ad3ia9vcceq2g"
        static let baseURL = "https://finnhub.io/api/v1/"
    }
    
    private init() {
        
    }
    
    //MARK: - Public
    
    public func search(query: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        guard let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        request(url: url(for: .search, queryParams: ["q":safeQuery]),
                expecting: SearchResponse.self,
                completion: completion)

    }
    
    
    //MARK: Private
    
    private enum Endpoint: String {
        case search
    }
    
    private enum APIError: Error {
        case invalidURL
        case noDataReturned
    }
    
    private func url(for endpoint: Endpoint,
                     queryParams: [String: String] = [:]) -> URL? {
        var urlString = Constants.baseURL + endpoint.rawValue
        
        var queryItems = [URLQueryItem]()
        // Add any parameters
        for (name, value) in queryParams {
            queryItems.append(.init(name: name, value: value))
        }
        
        // Add token
        queryItems.append(.init(name: "token", value: Constants.apiKey))
        
        // Convert query items to suffix string
        
        urlString += "?" + queryItems.map { "\($0.name)=\($0.value ?? "")"}.joined(separator: "&")
        
        print("\n\(urlString)\n")
        
        return URL(string: urlString)
    }
    
    private func request<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = url else {
            // Invalid URL
            completion(.failure(APIError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                else {
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }
            
            do  {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        })
        
        task.resume()
    }
}
