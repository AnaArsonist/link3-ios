//
//  NFTViewModel.swift
//  link3
//
//  Created by Ana Howard and Antonio Fran Štignjedec on 28/07/2023.
//

import SwiftUI

public class NFTViewModel<T: Codable>: ObservableObject {
    let apiManager = APIManagerImpl()
    @Published var models: T?

    func fetch(type endpoint: AlchemyEndpoints) {
        let networkRequest = apiManager.networkRequest(baseURL: "https://eth-mainnet.g.alchemy.com",
                                                       endpoint: endpoint)

        apiManager.networkTask(request: networkRequest) { [weak self] (response: Result<T, Error>) in
            switch response {
            case .success(let models):
                DispatchQueue.main.async {
                    self?.models = models
                }
            case .failure(let error):
                print("Error fetching: \(error)")
            }
        }
    }
}

enum AlchemyEndpoints: Endpoint {
    case nfts(key: String, address: String, contract: String)

    var path: String {
        switch self {
        case .nfts(let key, let address, let contract):
            return "/nft/v2/\(key)/getNFTs?owner=\(address)&orderBy=transferTime&contractAddresses%5B%5D=\(contract)"
        }
    }

    var method: Method {
        return .GET
    }
}
