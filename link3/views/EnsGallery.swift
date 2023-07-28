//
//  EnsGallery.swift
//  link3
//
//  Created by Ana Howard on 24/07/2023.
//

import SwiftUI

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}


struct EnsGallery: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel = NFTViewModel<NFTListModel>()
    
    var body: some View {
        ScrollView{
            VStack {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(viewModel.models?.nfts ?? []) { nft in
                        VStack{
                            AsyncImage(
                                url: URL(string: nft.imageUrl?.replacingOccurrences(of: "image", with: "rasterize") ?? "https://images.unsplash.com/photo-1526336024174-e58f5cdd8e13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Y2F0fGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60"),
                                content: {image in
                                    image.resizable()
                                        .frame(width:175, height: 175)
                                        .cornerRadius(20)
                                    
                                },
                                placeholder: {
                                    ProgressView()
                                }
                            )
                        }
                    }
                }
            }
        }
        .onAppear{
            viewModel.fetch(type: .nfts(key: ProcessInfo.processInfo.environment["ALCHEMY_KEY"] ?? "", address: "0x2B5c7025998f88550Ef2fEce8bf87935f542C190", contract: "0x57f1887a8BF19b14fC0dF6Fd9B2acc9Af147eA85"))
        }
    }
}

// TODO: Add NameWrapper and DNS Name Support
// TODO: Add WalletConnect
// TODO: "Connect Wallet to View Names"

//#Preview {
//    EnsGallery()
//}
