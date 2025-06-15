//
//  Character.swift
//  rick-and-morty
//
//  Created by Jakub Kuciński on 15/06/2025.
//

import Foundation

struct Character: Identifiable, Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
}

struct Origin: Decodable {
    let name: String
}

struct Location: Decodable {
    let name: String
}
