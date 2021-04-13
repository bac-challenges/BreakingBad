//
//  Service.swift
//  BreakingBad
//
//  Created by emile on 04/04/2021.
//

import Foundation
import Combine

protocol EndPointType {
    var url: URL? { get }
}

protocol ServiceType {
    func get(_ endpoint: EndPointType) -> AnyPublisher<Data, Error>
}

struct Service: ServiceType {
    func get(_ endpoint: EndPointType) -> AnyPublisher<Data, Error> {
        
        guard let url = endpoint.url else { fatalError("BAD URL")}
        
        return URLSession.shared.dataTaskPublisher(for: url, cachedResponseOnError: true)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}

struct ServiceMock: ServiceType {
    func get(_ endpoint: EndPointType) -> AnyPublisher<Data, Error> {
        
        guard let url = endpoint.url else { fatalError("BAD URL")}
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("BAD DATA")
        }
        
        return Future<Data, Error> { promise in
            promise(.success(data))
        }.eraseToAnyPublisher()
    }
}
