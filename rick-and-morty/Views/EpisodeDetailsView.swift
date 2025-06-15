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
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Name: \(episode.name)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Episode Code: \(episode.episode)")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.blue.opacity(0.1))
            )

            HStack(spacing: 16) {
                Label("Air Date", systemImage: "calendar")
                    .foregroundColor(.gray)
                Spacer()
                Text(episode.air_date)
                    .fontWeight(.medium)
            }
            .padding(.horizontal)

            HStack(spacing: 16) {
                Label("Characters", systemImage: "person.3.fill")
                    .foregroundColor(.gray)
                Spacer()
                Text("\(episode.characters.count)")
                    .fontWeight(.medium)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .navigationTitle("Episode Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
