//
//  Episode.swift
//  rick-and-morty
//
//  Created by Jakub Kuciński on 15/06/2025.
//

import Foundation

struct Episode: Identifiable, Decodable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
}
