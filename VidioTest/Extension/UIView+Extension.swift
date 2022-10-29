//
//  UIView+Extension.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import UIKit

extension UIView {
    func getSuperView() -> UIView {
        guard let superview = superview else {
            fatalError("Super view is not initalized.")
        }
        
        return superview
    }
}

extension UIView {
    enum Axis {
        enum X {
            case left
            case right
        }
        enum Y {
            case top
            case bottom
        }
    }
    
    enum Relation {
        case greater
        case equal
        case less
    }
}

//MARK: - Constraints to superview
extension UIView {
    @discardableResult
    func fillSuperView(padding: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        return [
            pinLeading(to: .left, of: getSuperView(), constant: padding.left),
            pinTop(to: .top, of: getSuperView(), constant: padding.top),
            pinTrailing(to: .right, of: getSuperView(), constant: padding.right),
            pinBottom(to: .bottom, of: getSuperView(), constant: padding.bottom)
        ]
    }
    
    @discardableResult
    func pinLeadingToSuperView(
        side: UIView.Axis.X,
        constant: CGFloat = .zero,
        relation: UIView.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        return pinLeading(to: side, of: getSuperView(), constant: constant, relation: relation, priority: priority)
    }
    @discardableResult
    func pinTrailingToSuperView(
        side: UIView.Axis.X,
        constant: CGFloat = .zero,
        relation: UIView.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        return pinTrailing(to: side, of: getSuperView(), constant: constant, relation: relation, priority: priority)
    }
    @discardableResult
    func pinTopToSuperView(
        side: UIView.Axis.Y,
        constant: CGFloat = .zero,
        relation: UIView.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        return pinTop(to: side, of: getSuperView(), constant: constant, relation: relation, priority: priority)
    }
    @discardableResult
    func pinBottomToSuperView(
        side: UIView.Axis.Y,
        constant: CGFloat = .zero,
        relation: UIView.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        return pinBottom(to: side, of: getSuperView(), constant: constant, relation: relation, priority: priority)
    }
    
    @discardableResult
    func pinCenterVerticallyToSuperView(
        constant: CGFloat = .zero,
        relation: UIView.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        return configureYAxisDimension(centerYAnchor, to: getSuperView().centerYAnchor, constant: constant, relation: relation, priority: priority)
    }
    @discardableResult
    func pinCenterHorizontallyToSuperView(
        constant: CGFloat = .zero,
        relation: UIView.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        return configureXAxisDimension(centerXAnchor, to: getSuperView().centerXAnchor, constant: constant, relation: relation, priority: priority)
    }
}

//MARK: - Constraints to target view
extension UIView {
    @discardableResult
    func pinLeading(
        to side: UIView.Axis.X,
        of view: UIView,
        constant: CGFloat = .zero,
        relation: UIView.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        switch side {
        case .left:
            return configureXAxisDimension(leadingAnchor, to: view.leadingAnchor, constant: constant, relation: relation, priority: priority)
        case .right:
            return configureXAxisDimension(leadingAnchor, to: view.trailingAnchor, constant: constant, relation: relation, priority: priority)
        }
    }
    
    @discardableResult
    func pinTrailing(
        to side: UIView.Axis.X,
        of view: UIView,
        constant: CGFloat = .zero,
        relation: UIView.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        switch side {
        case .left:
            return configureXAxisDimension(trailingAnchor, to: view.leadingAnchor, constant: -constant, relation: relation, priority: priority)
        case .right:
            return configureXAxisDimension(trailingAnchor, to: view.trailingAnchor, constant: -constant, relation: relation, priority: priority)
        }
    }
    
    @discardableResult
    func pinTop(
        to side: UIView.Axis.Y,
        of view: UIView,
        constant: CGFloat = .zero,
        relation: UIView.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        switch side {
        case .top:
            return configureYAxisDimension(topAnchor, to: view.topAnchor, constant: constant, relation: relation, priority: priority)
        case .bottom:
            return configureYAxisDimension(topAnchor, to: view.bottomAnchor, constant: constant, relation: relation, priority: priority)
        }
    }
    
    @discardableResult
    func pinBottom(
        to side: UIView.Axis.Y,
        of view: UIView,
        constant: CGFloat = .zero,
        relation: UIView.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        switch side {
        case .top:
            return configureYAxisDimension(bottomAnchor, to: view.topAnchor, constant: -constant, relation: relation, priority: priority)
        case .bottom:
            return configureYAxisDimension(bottomAnchor, to: view.bottomAnchor, constant: -constant, relation: relation, priority: priority)
        }
    }
    
    @discardableResult
    func pinCenterVertically(
        to view: UIView,
        constant: CGFloat = .zero,
        relation: UIView.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        return configureYAxisDimension(centerYAnchor, to: view.centerYAnchor, constant: constant, relation: relation, priority: priority)
    }
    
    @discardableResult
    func pinCenterHorizontally(
        to view: UIView,
        constant: CGFloat = .zero,
        relation: UIView.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        return configureXAxisDimension(centerXAnchor, to: view.centerXAnchor, constant: constant, relation: relation, priority: priority)
    }
}

//MARK: - Constraints to size view
extension UIView {
    @discardableResult
    func pinWidth(
        constant: CGFloat = .zero,
        relation: UIView.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        return configureSizeDimension(widthAnchor, constant: constant, relation: relation, priority: priority)
    }
    
    @discardableResult
    func pinHeight(
        constant: CGFloat = .zero,
        relation: UIView.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        return configureSizeDimension(heightAnchor, constant: constant, relation: relation, priority: priority)
    }
    
    @discardableResult
    func pinSize(
        _ size: CGSize,
        relation: UIView.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> [NSLayoutConstraint] {
        return [
            configureSizeDimension(widthAnchor, constant: size.width, relation: relation, priority: priority),
            configureSizeDimension(heightAnchor, constant: size.height, relation: relation, priority: priority)
        ]
    }
}

//MARK: Private methods
extension UIView {
    @discardableResult
    private func configureXAxisDimension(
        _ dimension: NSLayoutXAxisAnchor,
        to target: NSLayoutXAxisAnchor,
        constant: CGFloat,
        relation: UIView.Relation,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint
        switch relation {
        case .greater:
            constraint = dimension.constraint(greaterThanOrEqualTo: target, constant: constant)
        case .equal:
            constraint = dimension.constraint(equalTo: target, constant: constant)
        case .less:
            constraint = dimension.constraint(lessThanOrEqualTo: target, constant: constant)
        }
        
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    private func configureYAxisDimension(
        _ dimension: NSLayoutYAxisAnchor,
        to target: NSLayoutYAxisAnchor,
        constant: CGFloat,
        relation: UIView.Relation,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint
        switch relation {
        case .greater:
            constraint = dimension.constraint(greaterThanOrEqualTo: target, constant: constant)
        case .equal:
            constraint = dimension.constraint(equalTo: target, constant: constant)
        case .less:
            constraint = dimension.constraint(lessThanOrEqualTo: target, constant: constant)
        }
        
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    private func configureSizeDimension(
        _ dimension: NSLayoutDimension,
        constant: CGFloat,
        relation: UIView.Relation,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint
        switch relation {
        case .greater:
            constraint = dimension.constraint(greaterThanOrEqualToConstant: constant)
        case .equal:
            constraint = dimension.constraint(equalToConstant: constant)
        case .less:
            constraint = dimension.constraint(lessThanOrEqualToConstant: constant)
        }
        
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
}
