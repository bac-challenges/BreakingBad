//
//  DIContainer.swift
//  BreakingBad
//
//  Created by emile on 04/04/2021.
//

import UIKit

// MARK: - InjectionMap
struct InjectionMap {
    static var listCoordinator: ListCoordinatorType = ListCoordinator()
    static var listViewModel = ListViewModel()
    static var listModel: ListModelType = ListModel()
    static var service: ServiceType = Service()
}

// MARK: ListCoordinator
protocol ListCoordinatorInjected {}
extension ListCoordinatorInjected {
    var listCoordinator: ListCoordinatorType { get { return InjectionMap.listCoordinator } }
}

// MARK: ListViewModel
protocol ListViewModelInjected {}
extension ListViewModelInjected {
    var listViewModel: ListViewModel { get { return InjectionMap.listViewModel } }
}

// MARK: ListModel
protocol ListModelInjected {}
extension ListModelInjected {
    var listModel: ListModelType { get { return InjectionMap.listModel } }
}

// MARK: Service
protocol ServiceInjected {}
extension ServiceInjected {
    var service: ServiceType { get { return InjectionMap.service } }
}


// MARK: - Util
extension InjectionMap {
    static var window = UIWindow(frame: UIScreen.main.bounds)
    static var navigationController = UINavigationController()
    static var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .base64
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return decoder
    }
    static var imageLoader: ImageLoaderType = ImageLoader()
}

// MARK: UIWindow
protocol WindowInjected {}
extension WindowInjected {
    var window: UIWindow { get { return InjectionMap.window } }
}

// MARK: UINavigationController
protocol NavigationControllerInjected {}
extension NavigationControllerInjected {
    var navigationController: UINavigationController { get { return InjectionMap.navigationController } }
}

// MARK: JSONDecoder
protocol JSONDecoderInjected {}
extension JSONDecoderInjected {
    var jsonDecoder: JSONDecoder { get { return InjectionMap.jsonDecoder } }
}

// MARK: ImageLoader
protocol ImageLoaderInjected {}
extension ImageLoaderInjected {
    var imageLoader: ImageLoaderType { get { return InjectionMap.imageLoader } }
}
