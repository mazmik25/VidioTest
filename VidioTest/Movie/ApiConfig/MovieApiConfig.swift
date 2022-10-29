//
//  MovieApiConfig.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import Foundation

enum MovieApiConfig {
    case getContents
}

extension MovieApiConfig: ApiConfig {
    var endpoint: String {
        switch self {
        case .getContents: return "https://vidio.com/api/movies"
        }
    }
    
    var httpMethod: ApiHttpMethod {
        switch self {
        case .getContents: return .get
        }
    }
    
    var headers: [String : String] {
        switch self {
        case .getContents: return [:]
        }
    }
    
    var params: [String : Any] {
        switch self {
        case .getContents: return [:]
        }
    }
}
