//
//  Coordinator.swift
//  BreakingBad
//
//  Created by emile on 04/04/2021.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    func childDidStop(_ child: Coordinator) {
        childCoordinators.removeAll { $0 === child }
    }
    
    func start(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
