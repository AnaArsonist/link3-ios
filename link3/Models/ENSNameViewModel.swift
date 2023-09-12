//
//  ENSNameViewModel.swift
//  link3
//
//  Created by Ana Howard and Antonio Fran Štignjedec on 28/07/2023.
//

import SwiftUI

public class ENSNameViewModel: ObservableObject {
    let apiManager = APIManagerImpl()
    @Published var names: [ENSName]?

    static let baseGQL = "query getNames($id: ID!) { account(id: $id) { domains(first: 1000) { name createdAt registration { expiryDate } } wrappedDomains(first: 1000) { domain { name createdAt registration { expiryDate } } } } }"

    func fetch(address: String) {
        let json: [String: Any] = ["query": Test.baseGQL, "variables": ["id": address.lowercased()], "operationName": "getNames"]

        let networkRequest = apiManager.networkRequest(baseURL: "https://api.thegraph.com", endpoint: TheGraphEndpoints.ens, headers: ["Content-Type": "application/json"])
        // TODO: integrate in apiManager
        request.httpBody = try! JSONSerialization.data(withJSONObject: json)

        apiManager.networkTask(request: networkRequest) { [weak self] (response: Result<TheGraphBaseResponseModel, Error>) in
            switch response {
            case .success(let data):
                let ownedNames = data.data.account.domains.filter { !$0.name.hasSuffix("addr.reverse") }.map { Test.ensNameFromRawDomain($0, wrapped: false) }
                let wrappedNames = data.data.account.wrappedDomains.map { $0.domain }.map { Test.ensNameFromRawDomain($0, wrapped: true) }

                DispatchQueue.main.async {
                    self?.names = ownedNames + wrappedNames
                }
            case .failure(let error):
                print("Error fetching: \(error)")
            }
        }
    }

    private static func ensNameFromRawDomain(_ domain: RawDomainModel, wrapped: Bool) -> ENSName {
        return ENSName(
            name: domain.name,
            image_url: "https://metadata.ens.domains/mainnet/avatar/\(domain.name)",
            createdAt: NSDate(timeIntervalSince1970: Double(domain.createdAt) ?? 0) as Date,
            expiresAt: domain.registration != nil ?
                            NSDate(timeIntervalSince1970: Double(domain.registration!.expiryDate) ?? 0) as Date :
                            nil,
            wrapped: wrapped
        )
    }
}

enum TheGraphEndpoints: Endpoint {
    case ens

    var path: String {
        switch self {
        case .ens:
            return "/subgraphs/name/ensdomains/ens"
        }
    }

    var method: Method {
        return .POST
    }
}
