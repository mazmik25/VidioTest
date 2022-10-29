//
//  MovieLandscapeItemView.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import UIKit

typealias MovieLandscapeButtonCallback = ((String?) -> Void)
final class MovieLandscapeItemView: CommonUIView {
    private let imageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let button: CommonUIButton = CommonUIButton()
    
    private var viewParam: MovieViewParam.Item?
    private var buttonTappedCallback: MovieLandscapeButtonCallback?
    
    override func commonInit() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(button)
        
        setupImageView()
        setupTitleLabel()
        setupButton()
    }
    
    func configure(viewParam: MovieViewParam.Item) {
        self.viewParam = viewParam
        titleLabel.text = viewParam.titleText
        button.setTitle(viewParam.buttonText, for: .normal)
        imageView.loadImage(from: viewParam.imageUrl)
    }
    
    func setOnButtonTappedCallback(_ buttonTappedCallback: MovieLandscapeButtonCallback?) {
        self.buttonTappedCallback = buttonTappedCallback
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        
        imageView.pinTopToSuperView(side: .top)
        imageView.pinLeadingToSuperView(side: .left, constant: 4)
        imageView.pinTrailingToSuperView(side: .right, constant: 4)
        imageView.pinHeight(constant: 120)
    }
    
    private func setupTitleLabel() {
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        titleLabel.textColor = .darkGray
        
        titleLabel.pinTop(to: .bottom, of: imageView, constant: 4)
        titleLabel.pinLeading(to: .left, of: imageView)
        titleLabel.pinTrailing(to: .right, of: imageView)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func setupButton() {
        button.pinTop(to: .bottom, of: titleLabel, constant: 8)
        button.pinLeading(to: .left, of: imageView)
        button.pinTrailing(to: .right, of: imageView)
        button.pinBottomToSuperView(side: .bottom, constant: 8)
        button.setCommonUIButtonCallback { [weak self] in
            self?.buttonTappedCallback?(
                self?.viewParam?.videoUrl
            )
        }
    }
}
