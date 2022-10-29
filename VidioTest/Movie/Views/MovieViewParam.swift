//
//  MovieViewParam.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import Foundation

struct MovieViewParam {
    enum Variant {
        case portrait
        case landscape
    }
    struct Item {
        let titleText: String?
        let buttonText: String?
        let videoUrl: String?
        let imageUrl: String?
    }
    
    let variant: MovieViewParam.Variant?
    let items: [MovieViewParam.Item]
}
