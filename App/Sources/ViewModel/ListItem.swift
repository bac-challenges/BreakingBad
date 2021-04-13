//
//  ListItem.swift
//  BreakingBad
//
//  Created by emile on 04/04/2021.
//

import Foundation

struct ListItem: DataItem {
    
    let image: String
    let name: String
    let occupation: [String]
    let status: String
    let nickname: String
    let season: [Int]?
    
    init(_ item: DataItem) {
        image = item.image
        name = item.name
        occupation = item.occupation
        status = item.status
        nickname = item.nickname
        season = item.season
    }
}
