//
//  ReusableCollectionViewCell.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import UIKit

final class ReusableCollectionViewCell<View: UIView>: UICollectionViewCell {
    
    let view: View = View()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.fillSuperView()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        view.fillSuperView()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let result = super.preferredLayoutAttributesFitting(layoutAttributes)
        let size = contentView.systemLayoutSizeFitting(
            CGSize(width: layoutAttributes.frame.width, height: .greatestFiniteMagnitude),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        result.size.width = size.width
        if size.height != .greatestFiniteMagnitude {
            result.frame.size.height = size.height
        }
        return result
    }
}
