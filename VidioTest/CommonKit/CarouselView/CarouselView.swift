//
//  CarouselView.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import Foundation
import UIKit

final class CarouselView: CommonUIView {
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    private var viewParam: CarouselViewParam = CarouselViewParam()
    private var cellForItem: ((UICollectionView, IndexPath) -> UICollectionViewCell)?
    private var onItemSelected: ((UICollectionView, IndexPath) -> Void)?
    
    var isScrollEnabled: Bool {
        get {
            return collectionView.isScrollEnabled
        } set {
            collectionView.isScrollEnabled = newValue
        }
    }
    
    var showsVerticalScrollIndicator: Bool {
        get {
            return collectionView.showsVerticalScrollIndicator
        } set {
            collectionView.showsVerticalScrollIndicator = newValue
        }
    }
    
    var showsHorizontalScrollIndicator: Bool {
        get {
            return collectionView.showsHorizontalScrollIndicator
        } set {
            collectionView.showsHorizontalScrollIndicator = newValue
        }
    }
    
    override var intrinsicContentSize: CGSize {
        var superSize = super.intrinsicContentSize
        superSize.height = viewParam.itemSize.height
        superSize.height += layout.sectionInset.top + layout.sectionInset.bottom
        return superSize
    }
    
    override func commonInit() {
        addSubview(collectionView)
        setupCollectionView()
        setupLayout()
        reloadData()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func configure(viewParam: CarouselViewParam) {
        self.viewParam = viewParam
        invalidateIntrinsicContentSize()
    }
    
    func setOnItemSelected(_ onItemSelected: ((UICollectionView, IndexPath) -> Void)?) {
        self.onItemSelected = onItemSelected
    }
    
    func register<View: UIView>(
        _ type: ReusableCollectionViewCell<View>.Type,
        reusableIdentifier: String,
        closure: ((ReusableCollectionViewCell<View>, IndexPath) -> Void)?
    ) {
        collectionView.register(type, forCellWithReuseIdentifier: reusableIdentifier)
        cellForItem = { collectionView, indexPath in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath)
            if let cell = cell as? ReusableCollectionViewCell<View> {
                closure?(cell, indexPath)
                return cell
            }
            
            return cell
        }
    }
    
    private func setupCollectionView() {
        isScrollEnabled = true
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.fillSuperView()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.className())
        cellForItem = { collectionView, indexPath in
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: UICollectionViewCell.className(),
                for: indexPath
            )
        }
    }
    
    private func setupLayout() {
        layout.scrollDirection = .horizontal
    }
}

extension CarouselView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cellForItem?(collectionView, indexPath) else {
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: UICollectionViewCell.className(),
                for: indexPath
            )
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewParam.itemsCount
    }
}

extension CarouselView: UICollectionViewDelegate,
                        UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onItemSelected?(collectionView, indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewParam.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewParam.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewParam.sectionInset
    }
}
