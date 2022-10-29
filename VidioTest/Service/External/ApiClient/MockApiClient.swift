//
//  MockApiClient.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import Foundation

final class MockApiClient: ApiClient {
    private let mockResponse: String
    
    init(mockResponse: String) {
        self.mockResponse = mockResponse
    }
    
    func createRequest(completion: @escaping ApiClientRequestCallback) {
        if mockResponse.isEmpty {
            completion(.failure(.invalidResponse))
        } else {
            let data = Data(mockResponse.utf8)
            completion(.success(data))
        }
    }
}
