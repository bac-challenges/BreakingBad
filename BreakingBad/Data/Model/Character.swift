//
//  Character.swift
//  BreakingBad
//
//  Created by emile on 28/12/2020.
//

import Foundation

struct Character: Codable, Identifiable {

    enum CodingKeys: String, CodingKey {
        case image = "img"
        case name = "name"
        case occupation = "occupation"
        case status = "status"
        case nickname = "nickname"
        case season = "appearance"
    }
    
    let id: String = UUID().uuidString
    let image: String
    let name: String
    let occupation: [String]
    let status: String
    let nickname: String
    let season: [Int]?
}

#if DEBUG
extension Character {
    static var preview: Character {
        return Character(image: "NA",
                         name: "Name",
                         occupation:["occupation"],
                         status: "status",
                         nickname: "nickname",
                         season: [1])
    }
}
#endif
