//
//  ImageLoader.swift
//  BreakingBad
//
//  Created by emile on 04/04/2021.
//

import Foundation
import UIKit.UIImage
import Combine

protocol ImageLoaderType {
    func loadImage(from url: String) -> AnyPublisher<UIImage?, Never>
}

public final class ImageLoader: ImageLoaderType, ServiceInjected {
    
    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()
    
    public func loadImage(from url: String) -> AnyPublisher<UIImage?, Never> {
        return service.get(EndPoint.image(url: url))
            .map { data -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .subscribe(on: backgroundQueue)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
