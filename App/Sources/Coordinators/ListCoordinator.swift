//
//  ListCoordinator.swift
//  BreakingBad
//
//  Created by emile on 04/04/2021.
//

import UIKit

protocol ListCoordinatorType: Coordinator {
    func navigateToDetails(_ item: ListItem)
}

final class ListCoordinator: ListCoordinatorType, WindowInjected, NavigationControllerInjected {

    var childCoordinators = [Coordinator]()

    func start() {
        let viewController = ListController()
        navigationController.setViewControllers([viewController], animated: true)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func navigateToDetails(_ item: ListItem) {
        let coordinator = DetailsCoordinator(parent: self, item: item)
        start(coordinator)
    }
}
