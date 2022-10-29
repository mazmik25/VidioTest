//
//  AppCoordinator.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import Foundation
import UIKit

final class AppCoordinator {
    private let navigationController = UINavigationController()
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    private lazy var moviewCoordinator = MovieCoordinator(rootViewController: navigationController)
    
    func start() {
        moviewCoordinator.run()
    }
}
