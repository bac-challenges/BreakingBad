//
//  RemoteRepository.swift
//  BreakingBad
//
//  Created by emile on 28/12/2020.
//

import Foundation
import Combine

protocol CharacterRepository: ObservableObject {
    var originalItems: [Character] { get set }
    var items: [Character] { get set }
    func loadCharacters()
    func search(query: String)
    func filter(query: Int)
    func clear()
}

final class RemoteRepository: CharacterRepository, ObservableObject {
    
    let service: Service
    let endpoint: EndPoint
    
    var originalItems: [Character] = []
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    var items: [Character] = [] {
        didSet { objectWillChange.send() }
    }
    
    init(service: Service = RemoteService(), endpoint: EndPoint = CharactersEndPoint.characters) {
        self.service = service
        self.endpoint = endpoint
    }
}

extension RemoteRepository {
    func loadCharacters() {
        service.fetch(endpoint: endpoint, params: nil) { (result: Result<[Character], ServiceError>) in
            DispatchQueue.main.sync {
                switch result {
                case .success(let response):
                    self.originalItems = response
                    self.items = response
                case .failure(let error): print(error)
                }
            }
        }
    }
    
    func search(query: String) {
        items = items.filter { $0.name.contains(query) }
    }
    
    func filter(query: Int) {
        items = items.filter { ($0.season?.contains(query) ?? false) }
    }
    
    func clear() {
        items = originalItems
    }
}
