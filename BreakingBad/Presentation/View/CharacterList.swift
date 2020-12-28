//
//  CharacterList.swift
//  BreakingBad
//
//  Created by emile on 28/12/2020.
//

import SwiftUI

struct CharacterList: View {

    @EnvironmentObject var store: RemoteRepository
    
    var body: some View {
        NavigationView {
            List() {
                Section(header: SearchBar()) {
                    ForEach(store.items) { item in
                        NavigationLink(destination: CharacterDetail(item: item)) {
                            CharacterRow(item: item)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Characters"), displayMode: .inline)
        }
        .onAppear {
            store.loadCharacters()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList()
    }
}
