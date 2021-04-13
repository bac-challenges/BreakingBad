//
//  DetailsCoordinator.swift
//  BreakingBad
//
//  Created by emile on 04/04/2021.
//

import UIKit
import SwiftUI

protocol DetailsCoordinatorType: Coordinator {}

final class DetailsCoordinator: DetailsCoordinatorType, NavigationControllerInjected {
    
    var childCoordinators = [Coordinator]()
    
    private var item: ListItem
    private weak var parent: Coordinator?
    
    init(parent: Coordinator, item: ListItem) {
        self.parent = parent
        self.item = item
    }
    
    func start() {
        let view = DetailsView(item: item)
        navigationController.show(view, sender: nil)
    }
}
