//
// SaleInfoListPrice.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct SaleInfoListPrice: Codable, Hashable {

    public var amount: Double?
    public var currencyCode: String?

    public init(amount: Double? = nil, currencyCode: String? = nil) {
        self.amount = amount
        self.currencyCode = currencyCode
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case amount
        case currencyCode
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(amount, forKey: .amount)
        try container.encodeIfPresent(currencyCode, forKey: .currencyCode)
    }
}
