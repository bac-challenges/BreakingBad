//
//  CharacterRow.swift
//  BreakingBad
//
//  Created by emile on 28/12/2020.
//

import SwiftUI

struct CharacterRow: View {
    
    @SwiftUI.Environment(\.imageCache) var cache: ImageCache
    
    let item: Character
    
    var body: some View {
        HStack {
            URLImage(url: URL(string: item.image)!)
                .frame(width: 44, height: 44)
                .cornerRadius(5)
            
            Text(item.name)
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRow(item: Character.preview)
    }
}
