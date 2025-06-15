//
//  EpisodeDetailsView.swift
//  rick-and-morty
//
//  Created by Jakub Kuciński on 15/06/2025.
//

import SwiftUI

struct EpisodeDetailsView: View {
    let episode: Episode

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(episode.name)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text(episode.episode)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text("Data emisji:")
                        Spacer()
                        Text(episode.air_date)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.gray)
                    
                    HStack {
                        Image(systemName: "person.3.fill")
                        Text("Liczba postaci:")
                        Spacer()
                        Text("\(episode.characters.count)")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.gray)
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                        )
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 6)
                )
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Szczegóły odcinka")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

#Preview {
    NavigationView {
        EpisodeDetailsView(
            episode: Episode(
                id: 1,
                name: "Pilot",
                air_date: "December 2, 2013",
                episode: "S01E01",
                characters: Array(repeating: "https://rickandmortyapi.com/api/character/1", count: 10)
            )
        )
    }
}
