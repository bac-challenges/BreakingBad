//
//  ListModel.swift
//  BreakingBad
//
//  Created by emile on 04/04/2021.
//

import Foundation
import Combine

protocol ListModelType: ServiceInjected, JSONDecoderInjected {
    func get() -> AnyPublisher<[RemoteItem], Error>
}

struct ListModel: ListModelType {
    func get() -> AnyPublisher<[RemoteItem], Error> {
        return service.get(EndPoint.remote)
            .decode(type: [RemoteItem].self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}

struct ListModelMock: ListModelType {
    func get() -> AnyPublisher<[RemoteItem], Error> {
        return service.get(EndPoint.mock)
            .decode(type: [RemoteItem].self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}
