//
//  CharacterDetail.swift
//  BreakingBad
//
//  Created by emile on 28/12/2020.
//

import SwiftUI

struct CharacterDetail: View {
    
    let item: Character
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack { Spacer() }
                
                URLImage(url: URL(string: item.image)!)
                    .frame(width: 200, height: 200)
                    .cornerRadius(5)
                
                VStack(alignment: .leading) {
                    HStack { Spacer() }
                    Text("Name").bold()
                    Text(item.name)
                }
                
                VStack(alignment: .leading) {
                    HStack { Spacer() }
                    Text("Occupation").bold()
                    ForEach(item.occupation, id: \.self) { item in
                        Text(item)
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack { Spacer() }
                    Text("Status").bold()
                    Text(item.status)
                }
                
                VStack(alignment: .leading) {
                    HStack { Spacer() }
                    Text("Nickname").bold()
                    Text(item.nickname)
                }
                
                VStack(alignment: .leading) {
                    HStack { Spacer() }
                    Text("Season appearance").bold()
                    Text(item.season?.map { String($0) }
                            .joined(separator: ", ") ?? "N/A")
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle(Text("Details"), displayMode: .inline)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetail(item: Character.preview)
    }
}
