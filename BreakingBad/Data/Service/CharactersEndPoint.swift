//
//  CharactersEndPoint.swift
//  BreakingBad
//
//  Created by emile on 28/12/2020.
//

import Foundation

enum CharactersEndPoint: EndPoint {
    
    case characters
    
    var baseURL: URL {
        return URL(string: "https://breakingbadapi.com/api/")!
    }
    
    var path: String {
        switch self {
        case .characters: return "characters"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default: return .GET
        }
    }
}
