//
//  NetworkManager.swift
//  FetchRewards_SenthilKumar
//
//  Created by Senthil Kumar on 16/08/21.
//

import Foundation

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

enum NetworkError: Error {
    case badStatus
    case nullData
    case invalidJSON
    case invalidURL
    case unknown
}

/***
 Network manager - Helper class to initiate network calls.
 */
class NetworkManager {
    func sendRequest(url: URL, requestType: RequestType, header: [String: String]?, completion: @escaping (Swift.Result<Data?, NetworkError>) -> Void)  {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        urlRequest.allHTTPHeaderFields = header
        
        let dataTask =  URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.badStatus))
                return
            }
            if httpResponse.statusCode != 200 {
                completion(.failure(.badStatus))
            } else if error == nil {
                completion(.success(data))
            } else {
                completion(.failure(.nullData))
            }
        }
        dataTask.resume()
    }
}
