//
//  NFTListModel.swift
//  link3
//
//  Created by Ana Howard and Antonio Fran Štignjedec on 28/07/2023.
//

import Foundation

public struct NFTListModel: Codable {
    let nfts: [NFT]

    enum CodingKeys: String, CodingKey {
        case nfts = "ownedNfts"
    }
}

public struct NFT: Codable, Identifiable {
    let contract: NFTContract
    let nftId: NFTID
    let balance: String
    let title: String
    let description: String
    let tokenUri: NFTTokenUri
    let media: [NFTMedia]
    let timeLastUpdated: String
    let contractMetadata: NFTContractMetadata

    public var id: UUID = UUID()
    var imageUrl: String? { media.first?.raw }

    enum CodingKeys: String, CodingKey {
        case contract, balance, title, description, tokenUri, media, timeLastUpdated, contractMetadata
        case nftId = "id"
    }
}

public struct NFTContract: Codable {
    let address: String
}

public struct NFTID: Codable {
    let tokenId: String
    let tokenMetadata: NFTTokenMetadata
}

public struct NFTTokenMetadata: Codable {
    let tokenType: String
}

public struct NFTTokenUri: Codable {
    let gateway: String
    let raw: String
}

public struct NFTMedia: Codable {
    let gateway: String
    let thumbnail: String?
    let raw: String
    let format: String?
}

public struct NFTContractMetadata: Codable {
    let name: String?
    let symbol: String?
    let totalSupply: String?
    let tokenType: String?
    let contractDeployer: String?
    let deployedBlockNumber: Int?
    let openSea: NFTOpenSea?
}

public struct NFTOpenSea: Codable {
    let floorPrice: Double?
    let collectionName: String?
    let safelistRequestStatus: String?
    let imageUrl: String?
    let description: String?
    let externalUrl: String?
    let lastIngestedAt: String?
}
