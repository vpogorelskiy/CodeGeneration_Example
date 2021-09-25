//
// BooksVolume.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct BooksVolume: Codable, Hashable {

    public var kind: String?
    public var id: String
    public var etag: String?
    public var selfLink: String
    public var volumeInfo: VolumeInfo
    public var saleInfo: SaleInfo?
    public var accessInfo: AnyCodable?
    public var searchInfo: AnyCodable?

    public init(kind: String? = nil, id: String, etag: String? = nil, selfLink: String, volumeInfo: VolumeInfo, saleInfo: SaleInfo? = nil, accessInfo: AnyCodable? = nil, searchInfo: AnyCodable? = nil) {
        self.kind = kind
        self.id = id
        self.etag = etag
        self.selfLink = selfLink
        self.volumeInfo = volumeInfo
        self.saleInfo = saleInfo
        self.accessInfo = accessInfo
        self.searchInfo = searchInfo
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case kind
        case id
        case etag
        case selfLink
        case volumeInfo
        case saleInfo
        case accessInfo
        case searchInfo
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(kind, forKey: .kind)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(etag, forKey: .etag)
        try container.encode(selfLink, forKey: .selfLink)
        try container.encode(volumeInfo, forKey: .volumeInfo)
        try container.encodeIfPresent(saleInfo, forKey: .saleInfo)
        try container.encodeIfPresent(accessInfo, forKey: .accessInfo)
        try container.encodeIfPresent(searchInfo, forKey: .searchInfo)
    }
}

