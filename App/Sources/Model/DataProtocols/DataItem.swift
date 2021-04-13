//
//  DataItem.swift
//  BreakingBad
//
//  Created by emile on 04/04/2021.
//

import Foundation

protocol DataItem {
    var image: String { get }
    var name: String { get }
    var occupation: [String] { get }
    var status: String { get }
    var nickname: String { get }
    var season: [Int]? { get }
}
