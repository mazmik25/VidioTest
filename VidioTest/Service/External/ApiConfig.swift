//
//  ApiConfig.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import Foundation
protocol ApiConfig {
    var endpoint: String { get }
    var httpMethod: ApiHttpMethod { get }
    var params: [String: Any] { get }
    var headers: [String: String] { get }
}
