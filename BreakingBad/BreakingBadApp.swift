//
//  BreakingBadApp.swift
//  BreakingBad
//
//  Created by emile on 28/12/2020.
//

import SwiftUI

@main
struct BreakingBadApp: App {
    var body: some Scene {
        WindowGroup {
            CharacterList().environmentObject(RemoteRepository())
        }
    }
}
