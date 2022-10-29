//
//  MoviesInteractor.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import Foundation

typealias MoviesInteractorCallback = ((Result<[MovieResponse], RequestError>) -> Void)
protocol MoviesInteractor {
    func getContents()
    func setOnGetContentsRetrieved(callback: MoviesInteractorCallback?)
}

final class MoviesInteractorImpl: MoviesInteractor {
    private var callback: MoviesInteractorCallback?
    private let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func getContents() {
        apiClient.createRequest { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let items: [MovieResponse] = try decoder.decode([MovieResponse].self, from: data)
                    self?.callback?(.success(items))
                } catch {
                    self?.callback?(
                        .failure(.failedToDecode(error))
                    )
                }
            case .failure(let error):
                self?.callback?(.failure(error))
            }
        }
    }
    
    func setOnGetContentsRetrieved(callback: MoviesInteractorCallback?) {
        self.callback = callback
    }
}
