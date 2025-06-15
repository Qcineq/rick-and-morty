//
//  CharactersResponse.swift
//  rick-and-morty
//
//  Created by Jakub Kuciński on 15/06/2025.
//

import Foundation

struct CharactersResponse: Decodable {
    let info: PageInfo
    let results: [Character]
}

struct PageInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
