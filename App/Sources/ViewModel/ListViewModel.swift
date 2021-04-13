//
//  ListViewModel.swift
//  BreakingBad
//
//  Created by emile on 04/04/2021.
//

import Foundation
import Combine

final class ListViewModel: ListModelInjected {
    
    @Published var items = [ListItem]()
    
    private var disposables: Set<AnyCancellable> = []
}

// MARK: - Actions
extension ListViewModel: ListCoordinatorInjected {
    
    func get() {
        listModel.get()
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .map(transform)
            .assign(to: \.items, on: self)
            .store(in: &disposables)
    }
    
    func navigateToDetails(_ item: ListItem) {
        listCoordinator.navigateToDetails(item)
    }
}

// MARK: - Helpers
private extension ListViewModel {
    func transform(_ items: [DataItem]) -> [ListItem] {
        items.map { item in
            ListItem(item)
        }
    }
}
