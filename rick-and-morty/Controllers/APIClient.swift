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

    func fetchAllCharacters() async throws -> [Character] {
        var allCharacters: [Character] = []
        var nextURL: URL? = URL(string: "https://rickandmortyapi.com/api/character")

        while let url = nextURL {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(CharactersResponse.self, from: data)
            allCharacters.append(contentsOf: response.results)
            nextURL = URL(string: response.info.next ?? "")
        }

        return allCharacters
    }

    func fetchEpisode(urlString: String) async throws -> Episode {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Episode.self, from: data)
    }
}
