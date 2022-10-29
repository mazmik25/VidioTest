//
//  MovieCoordinator.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import UIKit

final class MovieCoordinator {
    private let rootViewController: UINavigationController?
    
    init(rootViewController: UINavigationController?) {
        self.rootViewController = rootViewController
    }
    
    func run() {
        openListPage()
    }
    
    func openListPage() {
        let apiClient = MockApiClient(mockResponse: MockMovieResponse.mock)
        let interactor = MoviesInteractorImpl(apiClient: apiClient)
        let viewModel = MoviesViewModelImpl(interactor: interactor)
        let controller = MoviesViewController(viewModel: viewModel)
        controller.setOnItemSelected { [weak self] viewParam in
            self?.openDetailPage(viewParam: viewParam)
        }
        controller.setOnOpenUrl { url in
            guard let url: URL = URL(string: url.safeUnwrap()),
            UIApplication.shared.canOpenURL(url) else {
                return
            }
            
            UIApplication.shared.open(url)
        }
        rootViewController?.pushViewController(controller, animated: true)
    }
    
    func openDetailPage(viewParam: MovieViewParam.Item?) {
        guard let viewParam = viewParam else {
            return
        }

        print("Detail page opened \(viewParam)")
    }
}
