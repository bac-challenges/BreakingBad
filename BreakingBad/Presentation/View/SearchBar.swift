//
//  SearchBar.swift
//  BreakingBad
//
//  Created by emile on 28/12/2020.
//

import SwiftUI

struct SearchBar: View {
    
    @EnvironmentObject var store: RemoteRepository
    @State private var name = ""
    @State private var season = ""
    @State private var isActiveBar = false
    
    var body: some View {
        VStack {
            HStack {
                SearchField(title: "Search characters", store: store, text: $name, isActiveBar: $isActiveBar)
                
                Button(action: {
                    self.store.search(query: name)
                }) {
                    Image(systemName: "magnifyingglass")
                }.accentColor(.primary)
            }
            .padding(EdgeInsets(top: 8, leading: -10, bottom: 8, trailing: -10))
    
            HStack {
                SearchField(title: "Search by season", store: store, text: $season, isActiveBar: $isActiveBar)
                
                Button(action: {
                    self.store.filter(query: Int(season) ?? 0)
                }) {
                    Image(systemName: "magnifyingglass")
                }.accentColor(.primary)
            }
            .padding(EdgeInsets(top: 0, leading: -10, bottom: 8, trailing: -10))
        }
    }
}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
#endif
