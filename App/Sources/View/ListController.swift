//
//  ListController.swift
//  BreakingBad
//
//  Created by emile on 04/04/2021.
//

import UIKit
import Combine

final class ListController: UITableViewController, ListViewModelInjected {
    
    @Published var items = [ListItem]() {
        didSet {
            if items.count > 0 {
                tableView.reloadData()
                indicator.stopAnimating()
            }
        }
    }
    
    private var disposables: Set<AnyCancellable> = []
    
    private lazy var indicator: UIActivityIndicatorView = {
        UIActivityIndicatorView(style: .large)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureBinding()
        loadItems()
    }
}

// MARK: - Actions
private extension ListController {
    func loadItems() {
        indicator.startAnimating()
        listViewModel.get()
    }
    
    func navigateToDetails(_ indexPath: IndexPath) {
        listViewModel.navigateToDetails(items[indexPath.item])
    }
}

// MARK: - Binding
private extension ListController {
    func configureBinding() {
        listViewModel.$items
            .receive(on: RunLoop.main)
            .assign(to: \.items, on: self)
            .store(in: &disposables)
    }
}

// MARK: - UI
extension ListController {
    private func configureView() {
        
        title = "Characters"
        view.backgroundColor = .white
        
        tableView.register(ListCell.self)
        tableView.backgroundView = indicator
    }
}

// MARK: - UITableViewDataSource
extension ListController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ListCell
        cell.configure(items[indexPath.item])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetails(indexPath)
    }
}
