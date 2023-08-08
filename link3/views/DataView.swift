//
//  DataView.swift
//  link3
//
//  Created by Ana Howard on 22/07/2023.
//

import SwiftUI

struct EnstateResult: Decodable {
    let address: String?
    let avatar: String?
    let display: String
    let records: [String: String]
}

enum LoadState {
    case Loading
    case Success
    case Error
}

func truncateAddress(address: String) -> String {
    let index1 = address.index(address.startIndex, offsetBy: 5)
    let index2 = address.index(address.endIndex, offsetBy: -5)
    
    return address.prefix(upTo: index1) + "..." + address.suffix(from: index2)
}

struct DataView: View {
    @EnvironmentObject var searchData: SearchData
    @State private var result: EnstateResult?
    
    @State private var loadState: LoadState = LoadState.Loading
    
    func lookupEns() -> Void {
        let lookupName = searchData.ensName.lowercased()
            
        let url = URL(string: "https://enstate.rs/n/" + lookupName)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                loadState = LoadState.Error
                return
            }
            let res = String(data: data, encoding: .utf8)
            
            let textRes = res?.data(using: .utf8)!
            result = try? JSONDecoder().decode(EnstateResult.self, from: textRes!)
            
            if result == nil {
                loadState = LoadState.Error
                return
            }
            
            loadState = LoadState.Success
        }
        
        task.resume()
    }
        
    var body: some View {
        NavigationView {
            VStack {
                if loadState == LoadState.Loading {
                    ProgressView()
                } else if loadState == LoadState.Error {
                    Text("Invalid ENS name, try another one")
                } else if let theResult = result {
                    if let avatar = theResult.avatar {
                        AsyncImage(
                            url: URL(string: avatar),
                            content: {image in
                                image.resizable()
                                    .frame(width:150, height: 150)
                                    .cornerRadius(100)
                                
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                        
                    }
                    Image("MagnifyingGlassSimple_fix_attempt1")
                    Text(theResult.display).multilineTextAlignment(.center)
                    if let address = theResult.address {
                        Text(truncateAddress(address: address)).multilineTextAlignment(.center)
                    }
                    ForEach(Array(theResult.records.keys).sorted(by: {(a, b) in
                        return (recordData[a] != nil) == (recordData[b] != nil) ?
                        (recordData[a]?.friendlyName ?? theResult.records[a]!) < (recordData[b]?.friendlyName ?? theResult.records[b]!) :
                        recordData[a] != nil
                    }), id: \.self) { key in
                        RecordItem(recordKey: key, recordValue: theResult.records[key]!)
                    }
                } else {
                    Text("Failed to load")
                }
            }.padding(.top, 60)
        }.onAppear {
            lookupEns()
        }
    }
}

//#Preview {
//    let obj = SearchData()
//    obj.ensName = "antony.sh"
//    return DataView().environmentObject(obj)
//}
