//
//  RecordItem.swift
//  link3
//
//  Created by Ana Howard on 23/07/2023.
//

import SwiftUI
    
struct recordInfo {
    var image: Image
    var friendlyName: String
    var bg: Color
    
    var action: (_: String) -> Void
    
}

func tryBrowserOpen(url: URL?) -> Void {
    if let link = url, UIApplication.shared.canOpenURL(link) {
        UIApplication.shared.open(link)
    }
}

func doTheCopy(value: String) -> Void {
    UIPasteboard.general.string = value;
}

var recordData: [String: recordInfo] = [
    "com.twitter": recordInfo(image: Image("Twitter"), friendlyName: "Twitter", bg:.cyan, action: { value in
        tryBrowserOpen(url: URL(string: "https://x.com/" + value))
    }),
    "com.instagram": recordInfo(image: Image("Instagram"), friendlyName: "Instagram", bg:.pink, action: { value in
        tryBrowserOpen(url: URL(string: "https://instagram.com/" + value))
    }),
    "com.discord": recordInfo(image: Image("Discord"), friendlyName: "Discord", bg: .indigo, action: { value in
        doTheCopy(value: value) // TODO: this is exploitbale, fix later
    }),
    "org.telegram": recordInfo(image: Image("Telegram"), friendlyName: "Telegram", bg: .blue, action: { value in
        tryBrowserOpen(url: URL(string: "https://t.me/" + value))
    }),
    "com.github": recordInfo(image: Image("Github"), friendlyName: "GitHub", bg: .gray, action: { value in
        tryBrowserOpen(url: URL(string: "https://github.com/" + value))
    }),
    "email": recordInfo(image: Image(systemName: "envelope.fill"), friendlyName: "E-Mail", bg:.pink, action: {value in
        tryBrowserOpen(url: URL(string: "mailto:" + value))
    }),
    "url": recordInfo(image: Image(systemName: "safari"), friendlyName: "Website", bg: .purple, action: { value in
        tryBrowserOpen(url: URL(string: value))
    })
]


struct RecordItem: View {
    var recordKey: String
    var recordValue: String
    
    @Environment(\.colorScheme) var colorScheme
        
    var body: some View {
        Button(action: {
            if let data = recordData[recordKey] {
                data.action(recordValue)
                return
            }
            
            doTheCopy(value: recordValue)
        }) {
            HStack{
                if let style = recordData[recordKey] {
                    // good
                    HStack{
                        HStack {
                            style.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.white)
                            Text(style.friendlyName)
                                .foregroundStyle(.white)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        Text(recordValue)
                            .foregroundStyle(.white)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }.padding(.vertical, 20)
                } else {
                    // boring generic style
                    HStack{
                        HStack {
                            Image(systemName: "list.bullet")
                                
                            Text(recordKey)
                                .fontWeight(.bold)
                        }
                        .padding(.leading, 20)
                        Text(recordValue)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .padding(.trailing, 20)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    }
                    .frame(width: 300, height:60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(colorScheme == .dark ? Color.white : Color.black))
                        )
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: 300)
            .fixedSize(horizontal: false, vertical: true)
            .background(recordData[recordKey] != nil ? recordData[recordKey]!.bg : Color.clear)
            .cornerRadius(20)
        }.foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
        
    }
}

//#Preview {
//    OnboardingView()
//}
