//
//  ApiClient.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import Foundation

typealias ApiClientRequestCallback = ((Result<Data, RequestError>) -> Void)
protocol ApiClient {
    func createRequest(completion: @escaping ApiClientRequestCallback)
}

final class ApiClientImpl: ApiClient {
    private let apiConfig: ApiConfig
    
    init(apiConfig: ApiConfig) {
        self.apiConfig = apiConfig
    }
    
    func createRequest(completion: @escaping ApiClientRequestCallback) {
        guard let url: URL = URL(string: apiConfig.endpoint) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let request: URLRequest = initializeRequest(withURL: url)
        let task: URLSessionDataTask = initializeSession().dataTask(with: request) { data, response, error in
            if let error = error {
                completion(
                    .failure(.unknown(error))
                )
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  let data = data else {
                completion(
                    .failure(.invalidResponse)
                )
                return
            }
            let statusCode = response.statusCode
            switch statusCode {
            case 100..<200:
                completion(.failure(.information(statusCode)))
            case 200..<300:
                completion(.success(data))
            case 300..<400:
                completion(.failure(.redirection(statusCode)))
            case 400..<500:
                if response.statusCode == 401 {
                    completion(.failure(.unauthorized))
                } else {
                    completion(
                        .failure(.client(statusCode))
                    )
                }
            case 500..<600:
                completion(.failure(.server(statusCode)))
            default:
                completion(.failure(.unknown(
                    NSError(domain: "Unknown error occured", code: statusCode)
                )))
            }
        }
        task.resume()
    }
}

extension ApiClientImpl {
    private func initializeSession() -> URLSession {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: configuration)
        return session
    }
    
    private func initializeRequest(withURL url: URL) -> URLRequest {
        var request: URLRequest
        switch apiConfig.httpMethod {
        case .get:
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            let queryItems: [URLQueryItem] = apiConfig.params.compactMap { key, value in
                return URLQueryItem(name: key, value: "\(value)")
            }
            urlComponents.queryItems = queryItems
            urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            request = URLRequest(url: urlComponents.url!)
        default:
            request = URLRequest(url: url)
            do {
                let httpBody: Data = try JSONSerialization.data(withJSONObject: apiConfig.params)
                request.httpBody = httpBody
            } catch {
                print(error)
            }
        }
        
        request.httpMethod = apiConfig.httpMethod.toHttpMethodString()
        apiConfig.headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}

enum RequestError: Error {
    case invalidUrl
    case failedToDecode(Error)
    case invalidResponse
    case unauthorized
    case unknown(Error)
    case client(Int)
    case server(Int)
    case information(Int)
    case redirection(Int)
}
