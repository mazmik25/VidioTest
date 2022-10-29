//
//  MovieLandscapeView.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import UIKit

typealias MoviewViewCallback = ((MovieViewParam.Item?) -> Void)

final class MovieLandscapeView: CommonUIView {
    private let carouselView: CarouselView = CarouselView()
    private var callback: MoviewViewCallback?
    private var buttonCallback: MovieLandscapeButtonCallback?
    
    override func commonInit() {
        addSubview(carouselView)
        carouselView.fillSuperView()
    }
    
    func setOnMoviewViewCallback(_ callback: MoviewViewCallback?) {
        self.callback = callback
    }
    
    func setOnButtonCallback(_ buttonCallback: MovieLandscapeButtonCallback?) {
        self.buttonCallback = buttonCallback
    }
    
    func configure(viewParam: MovieViewParam) {
        carouselView.configure(
            viewParam: CarouselViewParam(
                itemsCount: viewParam.items.count,
                itemSize: .init(width: 120, height: 160),
                sectionInset: .init(top: 4, left: 8, bottom: 4, right: 8),
                spacing: 10
            )
        )
        carouselView.register(
            ReusableCollectionViewCell<MovieLandscapeItemView>.self,
            reusableIdentifier: MovieLandscapeItemView.className()
        ) { [weak self] cell, indexPath in
            guard let self = self, let viewParam = viewParam.items[safe: indexPath.item] else { return }
            cell.view.configure(viewParam: viewParam)
            cell.view.setOnButtonTappedCallback(self.buttonCallback)
        }
        carouselView.setOnItemSelected { [weak self] _, indexPath in
            guard let self = self else {
                return
            }
            self.callback?(
                viewParam.items[safe: indexPath.item]
            )
        }
        carouselView.reloadData()
    }
}
