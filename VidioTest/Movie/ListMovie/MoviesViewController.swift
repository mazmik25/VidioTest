//
//  MoviesViewController.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import UIKit

class MoviesViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 180)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private var viewModel: MoviesViewModel?
    private var viewParams: [MovieViewParam] = []
    private var onItemSelected: ((MovieViewParam.Item?) -> Void)?
    private var onOpenUrl: ((String?) -> Void)?
    
    init(viewModel: MoviesViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.addSubview(collectionView)
        setupCollectionView()
        bindViewModel()
    }
    
    func setOnItemSelected(onItemSelected: ((MovieViewParam.Item?) -> Void)?) {
        self.onItemSelected = onItemSelected
    }
    
    func setOnOpenUrl(onOpenUrl: ((String?) -> Void)?) {
        self.onOpenUrl = onOpenUrl
    }
    
    private func setupCollectionView() {
        collectionView.fillSuperView()
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.className())
        collectionView.register(ReusableCollectionViewCell<MovieLandscapeView>.self, forCellWithReuseIdentifier: MovieLandscapeView.className())
        collectionView.register(ReusableCollectionViewCell<MoviePortraitView>.self, forCellWithReuseIdentifier: MoviePortraitView.className())
    }
    
    private func bindViewModel() {
        viewModel?.setOnGetModels { [weak self] result in
            switch result {
            case .success(let models):
                self?.viewParams = models.compactMap { $0.getViewParam() }
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        viewModel?.getContents()
    }
}

extension MoviesViewController: UICollectionViewDataSource,
                                UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewParams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (
            viewParams[safe: section]?.items.count
        ).safeUnwrap()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewParams[safe: indexPath.section]?.variant {
        case .portrait: return dequeuePotraitViewCell(collectionView, indexPath: indexPath)
        case .landscape: return dequeueLandscapeViewCell(collectionView, indexPath: indexPath)
        case .none: return dequeueDefaultViewCell(collectionView, indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewParams[safe: indexPath.section]?.variant {
        case .portrait:
            let viewParam = viewParams[safe: indexPath.section]?.items[safe: indexPath.item]
            onItemSelected?(viewParam)
        case .landscape: return
        case .none: return
        }
    }
}

private extension MoviesViewController {
    func dequeuePotraitViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MoviePortraitView.className(),
            for: indexPath
        ) as? ReusableCollectionViewCell<MoviePortraitView>,
                let viewParam = viewParams[safe: indexPath.section]?.items[safe: indexPath.item] else {
            return dequeueDefaultViewCell(collectionView, indexPath: indexPath)
        }
        cell.view.configure(viewParam: viewParam)
        cell.view.setOnButtonTappedCallback(onOpenUrl)
        return cell
    }
    
    func dequeueLandscapeViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieLandscapeView.className(),
            for: indexPath
        ) as? ReusableCollectionViewCell<MovieLandscapeView>,
                let viewParam = viewParams[safe: indexPath.section] else {
            return dequeueDefaultViewCell(collectionView, indexPath: indexPath)
        }
        cell.view.configure(viewParam: viewParam)
        cell.view.setOnButtonCallback(onOpenUrl)
        cell.view.setOnMoviewViewCallback(onItemSelected)
        return cell
    }
    
    func dequeueDefaultViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.className(), for: indexPath)
        return cell
    }
}
