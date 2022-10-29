//
//  CarouselViewParam.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import UIKit

struct CarouselViewParam {
    let itemsCount: Int
    let itemSize: CGSize
    let sectionInset: UIEdgeInsets
    let spacing: CGFloat
    
    init(
        itemsCount: Int = .zero,
        itemSize: CGSize = .zero,
        sectionInset: UIEdgeInsets = .zero,
        spacing: CGFloat = .zero
    ) {
        self.itemsCount = itemsCount
        self.itemSize = itemSize
        self.sectionInset = sectionInset
        self.spacing = spacing
    }
}
