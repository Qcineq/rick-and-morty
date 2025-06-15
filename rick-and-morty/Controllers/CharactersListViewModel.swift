//
//  CharactersListViewModel.swift
//  rick-and-morty
//
//  Created by Jakub Kuciński on 15/06/2025.
//

import Foundation

@MainActor
class CharactersListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var hasLoaded = false

    func loadCharacters() async {
        isLoading = true
        errorMessage = nil
        do {
            characters = try await APIClient.shared.fetchCharacters()
            hasLoaded = true
        } catch {
            errorMessage = "Błąd podczas pobierania danych."
        }
        isLoading = false
    }

    func reset() {
        hasLoaded = false
        characters = []
        errorMessage = nil
    }
}
