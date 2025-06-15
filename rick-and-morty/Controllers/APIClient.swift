//
//  APIClient.swift
//  rick-and-morty
//
//  Created by Jakub Kuciński on 15/06/2025.
//

import Foundation

class APIClient {
    static let shared = APIClient()
    private init() {}

    func fetchCharacters() async throws -> [Character] {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(CharactersResponse.self, from: data).results
    }

    func fetchEpisode(urlString: String) async throws -> Episode {
        let url = URL(string: urlString)!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Episode.self, from: data)
    }
}
