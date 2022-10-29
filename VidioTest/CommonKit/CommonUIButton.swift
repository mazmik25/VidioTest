//
//  CommonUIButton.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import UIKit

typealias CommonUIButtonCallback = (() -> Void)

final class CommonUIButton: UIButton {
    private var callback: CommonUIButtonCallback?
    private var timer: Timer?
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = .red
            } else {
                backgroundColor = .darkGray
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setCommonUIButtonCallback(_ callback: CommonUIButtonCallback?) {
        self.callback = callback
    }
    
    private func commonInit() {
        titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        layer.cornerRadius = 4
        setTitleColor(.white, for: .normal)
        setTitleColor(.gray, for: .disabled)
        backgroundColor = .red
        addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func onButtonTapped() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(handleDebounce), userInfo: nil, repeats: false)
    }
    
    @objc
    private func handleDebounce() {
        callback?()
    }
}
