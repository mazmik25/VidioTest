//
//  ApiHttpMethod.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import Foundation
enum ApiHttpMethod: String {
    case get
    case post
    case delete
    case put
    
    func toHttpMethodString() -> String {
        return self.rawValue.uppercased()
    }
}
