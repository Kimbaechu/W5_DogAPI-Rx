//
//  Model.swift
//  W5_DogAPI
//
//  Created by Beomcheol Kwon on 2021/01/29.
//

import Foundation

// MARK: - Dog
struct DogList: Codable {
    let message: [String: [String]]
    let status: String
}

// MARK: - ImageLink
struct ImageLink: Codable {
    let message: String
    let status: String
}
