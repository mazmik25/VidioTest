//
//  MoviePortraitView.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import UIKit

typealias MoviePortraitButtonCallback = ((String?) -> Void)
final class MoviePortraitView: CommonUIView {
    private let imageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let button: CommonUIButton = CommonUIButton()
    
    private var viewParam: MovieViewParam.Item?
    private var buttonTappedCallback: MoviePortraitButtonCallback?
    
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
    
    func setOnButtonTappedCallback(_ buttonTappedCallback: MoviePortraitButtonCallback?) {
        self.buttonTappedCallback = buttonTappedCallback
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        
        imageView.pinTopToSuperView(side: .top, constant: 8)
        imageView.pinLeadingToSuperView(side: .left, constant: 10)
        imageView.pinBottomToSuperView(side: .bottom, constant: 8)
        imageView.pinWidth(constant: 120)
    }
    
    private func setupTitleLabel() {
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        
        titleLabel.pinTopToSuperView(side: .top, constant: 10)
        titleLabel.pinLeading(to: .right, of: imageView, constant: 8)
        titleLabel.pinTrailingToSuperView(side: .right, constant: 20)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func setupButton() {
        button.pinTop(to: .bottom, of: titleLabel, constant: 16)
        button.pinLeading(to: .right, of: imageView, constant: 8)
        button.pinWidth(constant: 120)
        button.setCommonUIButtonCallback { [weak self] in
            self?.buttonTappedCallback?(
                self?.viewParam?.videoUrl
            )
        }
    }
}
