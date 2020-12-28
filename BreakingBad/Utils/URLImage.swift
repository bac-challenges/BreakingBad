//
//  URLImage.swift
//  BreakingBad
//
//  Created by emile on 28/12/2020.
//

import SwiftUI

struct URLImage: View {
    @ObservedObject private var loader: ImageLoader
    
    init(url: URL) {
        loader = ImageLoader(url: url)
        loader.load()
    }
    var body: AnyView {
        if let uiImage = loader.image {
            return AnyView(Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill))
        } else {
            return AnyView(EmptyView())
        }
    }
}
