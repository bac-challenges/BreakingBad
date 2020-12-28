//
//  SearchField.swift
//  BreakingBad
//
//  Created by emile on 28/12/2020.
//

import SwiftUI

struct SearchField: View {
    let title: String
    var store: RemoteRepository
    @Binding var text: String
    @Binding var isActiveBar: Bool
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10).foregroundColor(.white)
            
            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(.secondary)
                
                TextField(title, text: $text, onEditingChanged: { isActive in
                    self.isActiveBar = isActive
                })
                
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                        self.store.clear()
                    }) {
                        Image(systemName: "multiply.circle")
                    }.accentColor(.secondary)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        }
    }
}
