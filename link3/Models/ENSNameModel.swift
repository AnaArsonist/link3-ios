//
//  ENSNameModel.swift
//  link3
//
//  Created by Antonio Fran Štignjedec on 11/09/2023.
//

import Foundation

public struct ENSName: Codable, Identifiable {
    public var id: String { name }

    let name: String
    // TODO: support for names without image
    let imageUrl: String
    let createdAt: Date
    let expiresAt: Date?
    let wrapped: Bool
}


//
// raw response models
//

public struct TheGraphBaseResponseModel: Codable {
    let data: TheGraphAccountModel
}

public struct TheGraphAccountModel: Codable {
    let account: TheGraphDomainModel
}

public struct TheGraphDomainModel: Codable {
    let domains: [RawDomainModel]
    let wrappedDomains: [WrappedDomainListModel]
}

public struct WrappedDomainListModel: Codable {
    let domain: RawDomainModel
}

public struct RawDomainModel: Codable {
    let name: String
    let createdAt: String
    let registration: RegistrationModel?
}

public struct RegistrationModel: Codable {
    let expiryDate: String
}