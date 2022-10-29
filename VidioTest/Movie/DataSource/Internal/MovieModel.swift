//
//  MovieModel.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import Foundation
struct MovieModel {
    enum Variant: String {
        case portrait
        case landscape
    }
    struct Item {
        let id: Int
        let title: String
        let videoUrl: String
        let imageUrl: String
    }
    
    let id: Int
    let variant: MovieModel.Variant?
    let items: [MovieModel.Item]
}

extension MovieModel.Variant {
    func getViewParam() -> MovieViewParam.Variant {
        switch self {
        case .portrait: return .portrait
        case .landscape: return .landscape
        }
    }
}

extension MovieModel.Item {
    func getViewParam() -> MovieViewParam.Item {
        return .init(
            titleText: title,
            buttonText: "Lihat Trailer",
            videoUrl: videoUrl,
            imageUrl: imageUrl
        )
    }
}

extension MovieModel {
    func getViewParam() -> MovieViewParam {
        return .init(
            variant: variant?.getViewParam(),
            items: items.compactMap { $0.getViewParam() }
        )
    }
}
