//
//  MoviesViewModel.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import Foundation

typealias MoviesViewModelCallback = ((Result<[MovieModel], Error>) -> Void)
protocol MoviesViewModel {
    func getContents()
    func setOnGetModels(callback: MoviesViewModelCallback?)
}

final class MoviesViewModelImpl: MoviesViewModel {
    private let interactor: MoviesInteractor
    private var callback: MoviesViewModelCallback?
    
    init(interactor: MoviesInteractor) {
        self.interactor = interactor
        bindInteractor()
    }
    
    func getContents() {
        interactor.getContents()
    }
    
    func setOnGetModels(callback: MoviesViewModelCallback?) {
        self.callback = callback
    }
    
    private func bindInteractor() {
        interactor.setOnGetContentsRetrieved { [weak self] result in
            switch result {
            case .success(let data):
                let models = data.compactMap { $0.getModel() }
                DispatchQueue.main.async {
                    self?.callback?(.success(models))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.callback?(.failure(error))
                }
            }
        }
    }
}
