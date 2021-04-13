//
//  RemoteItem.swift
//  BreakingBad
//
//  Created by emile on 04/04/2021.
//

import Foundation

struct RemoteItem: DataItem, Codable {
    
    enum CodingKeys: String, CodingKey {
        case image = "img"
        case name = "name"
        case occupation = "occupation"
        case status = "status"
        case nickname = "nickname"
        case season = "appearance"
    }
    
    let image: String
    let name: String
    let occupation: [String]
    let status: String
    let nickname: String
    let season: [Int]?
}
