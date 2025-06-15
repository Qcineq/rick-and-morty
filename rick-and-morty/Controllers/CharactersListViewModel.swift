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
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }

        do {
            let fetched = try await APIClient.shared.fetchAllCharacters()
            DispatchQueue.main.async {
                self.characters = fetched
                self.hasLoaded = true
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Error loading characters."
                self.isLoading = false
            }
        }
    }

    func reset() {
        hasLoaded = false
        characters = []
        errorMessage = nil
    }
}
