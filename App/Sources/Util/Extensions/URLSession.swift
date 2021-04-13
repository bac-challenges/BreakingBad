//
//  URLSession.swift
//  BreakingBad
//
//  Created by emile on 04/04/2021.
//

import Foundation
import Combine

typealias ShortOutput = URLSession.DataTaskPublisher.Output

extension URLSession {
    
    func dataTaskPublisher(for url: URL, cachedResponseOnError: Bool) -> AnyPublisher<ShortOutput, Error> {
        
        return self.dataTaskPublisher(for: url)
            .tryCatch { [weak self] (error) -> AnyPublisher<ShortOutput, Never> in
                
                guard cachedResponseOnError,
                      let urlCache = self?.configuration.urlCache,
                      let cachedResponse = urlCache.cachedResponse(for: URLRequest(url: url))
                else {
                    throw error
                }
                
                return Just(ShortOutput(
                    data: cachedResponse.data,
                    response: cachedResponse.response
                )).eraseToAnyPublisher()
                
            }.eraseToAnyPublisher()
    }
}
