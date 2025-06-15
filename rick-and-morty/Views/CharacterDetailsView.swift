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
            VStack(alignment: .leading, spacing: 12) {
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(height: 250)
                .cornerRadius(10)

                Group {
                    Text("Name: \(character.name)")
                    Text("Status: \(character.status)")
                    Text("Gender: \(character.gender)")
                    Text("Origin: \(character.origin.name)")
                    Text("Location: \(character.location.name)")
                }
                .padding(.horizontal)

                Divider()
                Text("Odcinki:")
                    .font(.headline)
                    .padding(.horizontal)

                ForEach(episodes) { episode in
                    NavigationLink(destination: EpisodeDetailsView(episode: episode)) {
                        Text("Odcinek \(episode.episode)")
                            .padding(.horizontal)
                    }
                }
            }
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
