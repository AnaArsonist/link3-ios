//
//  NewNameView.swift
//  link3
//
//  Created by Ana Howard on 24/07/2023.
//

import SwiftUI

struct NewNameView: View {
    @State private var search = ""
    @Environment (\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack{
            Text("Your web3 username")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            TextField("Search for a name", text: $search)
                .multilineTextAlignment(.center)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .disableAutocorrection(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 10)
                .padding(.vertical, 20)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(colorScheme == .dark ? Color.white : Color.black))
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 40)

        }
}

//#Preview {
//    NewNameView()
//}
