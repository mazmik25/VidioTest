//
//  MovieResponse.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import Foundation
struct MovieResponse: Decodable {
    struct Item: Decodable {
        let id: Int?
        let title: String?
        let videoUrl: String?
        let imageUrl: String?
    }
    
    let id: Int?
    let variant: String?
    let items: [MovieResponse.Item]
}

extension MovieResponse.Item {
    func getModel() -> MovieModel.Item {
        return .init(
            id: id.safeUnwrap(),
            title: title.safeUnwrap(),
            videoUrl: videoUrl.safeUnwrap(),
            imageUrl: imageUrl.safeUnwrap()
        )
    }
}

extension MovieResponse {
    func getModel() -> MovieModel {
        return .init(
            id: id.safeUnwrap(),
            variant: .init(rawValue: variant.safeUnwrap()),
            items: items.compactMap { $0.getModel() }
        )
    }
}
