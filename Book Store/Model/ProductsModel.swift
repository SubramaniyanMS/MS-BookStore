//
//  ProductsModel.swift
//  Book Store
//
//  Created by Apple on 30/09/24.
//

import Foundation

// MARK: - Welcome
struct StoreProducts: Codable {
    let products: Products?
}

// MARK: - Products
struct Products: Codable {
    let yg: Product?
    let li: Product?
    let wl: Product?
    let cp, dt, gm, mr: Product?
    let mp: Product?
    let ed, ppol, pcol, bp: Product?

    enum CodingKeys: String, CodingKey {
        case yg = "YG"
        case li = "LI"
        case wl = "WL"
        case cp = "CP"
        case dt = "DT"
        case gm = "GM"
        case mr = "MR"
        case mp = "MP"
        case ed = "ED"
        case ppol = "PPOL"
        case pcol = "PCOL"
        case bp = "BP"
    }
}

// MARK: - Product
struct Product: Codable {
    let name, description: String?
    let availableLanguages: [String]?
    let pages: Int?
    let pagesintext, reportType, authentic, remedies: String?
    let vedic: String?
    let price, discount, appDiscount, couponDiscount: Int?
    let imagePath: ImagePath?
    let soldcount: String?
    let avg: Avg?
}

enum Avg: Codable {
    case double(Double)
    case integer(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        throw DecodingError.typeMismatch(Avg.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Avg"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ImagePath
struct ImagePath: Codable {
    let square: String?
    let wide: String?
}
