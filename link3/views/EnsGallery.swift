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

struct EnsNameEntry: View {
    @State var ens: ENSName

    @State private var isSheetPresented = false

    var body: some View {
        Button(action: {
            isSheetPresented = true
        }){
            VStack{
                AsyncImage(
                    url: URL(string: ens.imageUrl),
                    content: { image in
                        image.resizable()
                            .frame(width:175, height: 175)
                            .cornerRadius(20)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
            }
        }.sheet(isPresented: $isSheetPresented) {
            DataView().environmentObject(SearchData(ensName: ens.name))
        }
    }
}

struct EnsGallery: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel = ENSNameViewModel()
    
    var body: some View {
        ScrollView{
            VStack {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    // TODO: sort
                    ForEach(viewModel.names ?? []) { name in
                        EnsNameEntry(ens: name)
                    }
                }
            }.padding(.top, 10)
        }
        .onAppear{
            viewModel.fetch(address: "0x95E1D29b0B29257aF04D0991443df2bc2eA317D6")
        }
    }
}

// TODO: Add NameWrapper and DNS Name Support
//  note: ^^^^ should be done, needs testing

// TODO: Add WalletConnect
// TODO: "Connect Wallet to View Names"

//#Preview {
//    TabNav()
//}
