//
//  CharacterDetailsView.swift
//  rick-and-morty
//
//  Created by Jakub Kuciński on 15/06/2025.
//

import SwiftUI

struct CharacterDetailsView: View {
    let character: Character
    @State private var episodes: [Episode] = []

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 260)
                .clipped()
                .cornerRadius(20)
                .shadow(radius: 6)
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    Text(character.name)
                        .font(.title)
                        .fontWeight(.bold)
                    HStack {
                        Label(character.status, systemImage: "waveform.path.ecg")
                        Label(character.gender, systemImage: "person.fill")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                    Divider()

                    VStack(alignment: .leading, spacing: 6) {
                        Label("Origin: \(character.origin.name)", systemImage: "globe")
                        Label("Location: \(character.location.name)", systemImage: "mappin.and.ellipse")
                    }
                    .font(.subheadline)
                }
                .padding(.horizontal)

                Divider()

                VStack(alignment: .leading, spacing: 12) {
                    Text("Episodes")
                        .font(.title3)
                        .fontWeight(.semibold)
                    ForEach(episodes) { episode in
                        NavigationLink(destination: EpisodeDetailsView(episode: episode)) {
                            HStack {
                                Text("Odcinek: \(episode.episode) - \(episode.name)")
                                    .font(.subheadline)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
            .task {
                await loadEpisodes()
            }
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    func loadEpisodes() async {
        do {
            let results = try await withThrowingTaskGroup(of: Episode.self) { group -> [Episode] in
                for url in character.episode {
                    group.addTask {
                        try await APIClient.shared.fetchEpisode(urlString: url)
                    }
                }

                var episodes: [Episode] = []
                for try await result in group {
                    episodes.append(result)
                }
                return episodes
            }
            self.episodes = results.sorted(by: { $0.id < $1.id })
        } catch {
            print("Error loading episodes: \(error)")
        }
    }
}

#Preview {
    NavigationView {
        CharacterDetailsView(
            character: Character(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                gender: "Male",
                origin: Origin(name: "Earth (C-137)"),
                location: Location(name: "Citadel of Ricks"),
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                episode: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2"
                ]
            )
        )
    }
    }
