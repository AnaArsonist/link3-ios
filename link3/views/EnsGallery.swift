//
//  EnsGallery.swift
//  link3
//
//  Created by Ana Howard on 24/07/2023.
//

import SwiftUI

struct EnsGallery: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView{
            VStack {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(0..<10) { _ in
                        VStack{
                            Image(systemName:"seal")
                                .foregroundColor(colorScheme == .dark ? .white : .black)                             .font(.system(size: 150))
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    EnsGallery()
//}
