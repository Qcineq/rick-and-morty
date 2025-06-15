//
//  ContentView.swift
//  rick-and-morty
//
//  Created by Jakub Kuciński on 14/06/2025.
//

import SwiftUI

struct CharactersListView: View {
    @StateObject private var viewModel = CharactersListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.hasLoaded {
                    if viewModel.isLoading {
                        ProgressView("Ładowanie...")
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    } else {
                        List(viewModel.characters) { character in
                            NavigationLink(destination: CharacterDetailsView(character: character)) {
                                HStack {
                                    AsyncImage(url: URL(string: character.image)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    Text(character.name)
                                }
                            }
                        }
                    }
                } else {
                    Spacer()
                    Text("Naciśnij przycisk poniżej, aby wczytać listę bohaterów.")
                        .multilineTextAlignment(.center)
                        .padding()
                    Button("Wczytaj bohaterów") {
                        Task {
                            await viewModel.loadCharacters()
                        }
                    }
                    Spacer()
                }

                Button("Resetuj widok") {
                    viewModel.reset()
                }
                .padding(.top)
            }
            .navigationTitle("Rick & Morty")
        }
    }
}

#Preview {
    CharactersListView()
}
